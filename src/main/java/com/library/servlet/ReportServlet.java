package com.library.servlet;

import com.library.dao.BookDAO;
import com.library.dao.BookIssueDAO;
import com.library.dao.UserDAO;
import com.library.model.Book;
import com.library.model.BookIssue;
import com.library.model.User;

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

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private BookDAO bookDAO;
    private UserDAO userDAO;
    private BookIssueDAO issueDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
        issueDAO = new BookIssueDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get all data
        List<Book> allBooks = bookDAO.getAllBooks();
        List<User> allStudents = userDAO.getStudents();
        List<BookIssue> allIssues = issueDAO.getAllIssues();
        List<BookIssue> overdueIssues = issueDAO.getOverdueIssues();
        
        // Calculate statistics
        int totalBooks = allBooks.size();
        int availableBooks = 0;
        for (Book book : allBooks) {
            availableBooks += book.getAvailableCopies();
        }
        
        int issuedBooks = 0;
        int returnedBooks = 0;
        for (BookIssue issue : allIssues) {
            if (issue.getStatus() == BookIssue.IssueStatus.ISSUED) {
                issuedBooks++;
            } else if (issue.getStatus() == BookIssue.IssueStatus.RETURNED) {
                returnedBooks++;
            }
        }
        
        int totalStudents = allStudents.size();
        int overdueCount = overdueIssues.size();
        
        // Category-wise book count
        Map<String, Integer> categoryCount = new HashMap<String, Integer>();
        for (Book book : allBooks) {
            String category = book.getCategory();
            categoryCount.put(category, categoryCount.getOrDefault(category, 0) + 1);
        }
        
        // Set attributes
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("availableBooks", availableBooks);
        request.setAttribute("issuedBooks", issuedBooks);
        request.setAttribute("returnedBooks", returnedBooks);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("overdueCount", overdueCount);
        request.setAttribute("categoryCount", categoryCount);
        request.setAttribute("allBooks", allBooks);
        
        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}