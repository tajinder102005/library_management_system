package com.library.servlet;

import com.library.dao.BookDAO;
import com.library.dao.BookIssueDAO;
import com.library.dao.UserDAO;
import com.library.model.Book;
import com.library.model.BookIssue;
import com.library.model.User;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/issues")
public class BookIssueServlet extends HttpServlet {
    private BookIssueDAO issueDAO;
    private BookDAO bookDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        issueDAO = new BookIssueDAO();
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listIssues(request, response);
                break;
            case "issue":
                showIssueForm(request, response);
                break;
            case "return":
                showReturnForm(request, response);
                break;
            case "overdue":
                listOverdueIssues(request, response);
                break;
            default:
                listIssues(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("issue".equals(action)) {
            issueBook(request, response);
        } else if ("return".equals(action)) {
            returnBook(request, response);
        }
    }
    
    private void listIssues(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BookIssue> issues = issueDAO.getAllIssues();
        List<Map<String, Object>> issuesWithDetails = new ArrayList<Map<String, Object>>();
        
        for (BookIssue issue : issues) {
            Map<String, Object> issueDetail = new HashMap<String, Object>();
            issueDetail.put("issue", issue);
            issueDetail.put("book", bookDAO.getBookById(issue.getBookId()));
            issueDetail.put("user", userDAO.getUserById(issue.getUserId()));
            issuesWithDetails.add(issueDetail);
        }
        
        request.setAttribute("issues", issuesWithDetails);
        request.getRequestDispatcher("/admin/issues.jsp").forward(request, response);
    }
    
    private void listOverdueIssues(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BookIssue> overdueIssues = issueDAO.getOverdueIssues();
        List<Map<String, Object>> issuesWithDetails = new ArrayList<Map<String, Object>>();
        
        for (BookIssue issue : overdueIssues) {
            Map<String, Object> issueDetail = new HashMap<String, Object>();
            issueDetail.put("issue", issue);
            issueDetail.put("book", bookDAO.getBookById(issue.getBookId()));
            issueDetail.put("user", userDAO.getUserById(issue.getUserId()));
            issuesWithDetails.add(issueDetail);
        }
        
        request.setAttribute("issues", issuesWithDetails);
        request.setAttribute("overdueOnly", true);
        request.getRequestDispatcher("/admin/overdue.jsp").forward(request, response);
    }
    
    private void showIssueForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> availableBooks = new ArrayList<Book>();
        for (Book book : bookDAO.getAllBooks()) {
            if (book.isAvailable()) {
                availableBooks.add(book);
            }
        }
        
        List<User> students = userDAO.getStudents();
        
        request.setAttribute("books", availableBooks);
        request.setAttribute("students", students);
        request.getRequestDispatcher("/admin/issue-book.jsp").forward(request, response);
    }
    
    private void showReturnForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BookIssue> activeIssues = new ArrayList<BookIssue>();
        for (BookIssue issue : issueDAO.getAllIssues()) {
            if (issue.getStatus() == BookIssue.IssueStatus.ISSUED) {
                activeIssues.add(issue);
            }
        }
        
        List<Map<String, Object>> issuesWithDetails = new ArrayList<Map<String, Object>>();
        for (BookIssue issue : activeIssues) {
            Map<String, Object> issueDetail = new HashMap<String, Object>();
            issueDetail.put("issue", issue);
            issueDetail.put("book", bookDAO.getBookById(issue.getBookId()));
            issueDetail.put("user", userDAO.getUserById(issue.getUserId()));
            issuesWithDetails.add(issueDetail);
        }
        
        request.setAttribute("issues", issuesWithDetails);
        request.getRequestDispatcher("/admin/return-book.jsp").forward(request, response);
    }
    
    private void issueBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String bookId = request.getParameter("bookId");
            String userId = request.getParameter("userId");
            
            if (bookId == null || userId == null || bookId.isEmpty() || userId.isEmpty()) {
                request.setAttribute("error", "Please select both book and student");
                showIssueForm(request, response);
                return;
            }
            
            ObjectId bookObjectId = new ObjectId(bookId);
            ObjectId userObjectId = new ObjectId(userId);
            
            // Check if user already has this book
            BookIssue existingIssue = issueDAO.getActiveIssueForBook(bookObjectId, userObjectId);
            if (existingIssue != null) {
                request.setAttribute("error", "This student already has this book issued");
                showIssueForm(request, response);
                return;
            }
            
            // Check if book is available
            Book book = bookDAO.getBookById(bookObjectId);
            if (book == null) {
                request.setAttribute("error", "Book not found");
                showIssueForm(request, response);
                return;
            }
            
            if (!book.isAvailable()) {
                request.setAttribute("error", "Book is not available (all copies are issued)");
                showIssueForm(request, response);
                return;
            }
            
            // Issue the book
            BookIssue issue = new BookIssue(bookObjectId, userObjectId);
            
            if (issueDAO.issueBook(issue)) {
                bookDAO.updateAvailableCopies(bookObjectId, -1);
                request.getSession().setAttribute("success", "Book '" + book.getTitle() + "' issued successfully!");
                response.sendRedirect(request.getContextPath() + "/issues?action=list");
                return;
            } else {
                request.setAttribute("error", "Failed to issue book");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid book or user ID");
        } catch (Exception e) {
            request.setAttribute("error", "Error issuing book: " + e.getMessage());
        }
        
        showIssueForm(request, response);
    }
    
    private void returnBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String issueId = request.getParameter("issueId");
            String notes = request.getParameter("notes");
            
            BookIssue issue = issueDAO.getIssueById(new ObjectId(issueId));
            
            if (issue != null && issue.getStatus() == BookIssue.IssueStatus.ISSUED) {
                if (issueDAO.returnBook(new ObjectId(issueId), notes)) {
                    bookDAO.updateAvailableCopies(issue.getBookId(), 1);
                    request.setAttribute("success", "Book returned successfully");
                } else {
                    request.setAttribute("error", "Failed to return book");
                }
            } else {
                request.setAttribute("error", "Invalid issue record");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error returning book: " + e.getMessage());
        }
        
        showReturnForm(request, response);
    }
}