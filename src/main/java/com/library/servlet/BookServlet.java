package com.library.servlet;

import com.library.dao.BookDAO;
import com.library.model.Book;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private BookDAO bookDAO;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
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
                listBooks(request, response);
                break;
            case "search":
                searchBooks(request, response);
                break;
            case "view":
                viewBook(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBook(request, response);
                break;
            default:
                listBooks(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addBook(request, response);
        } else if ("update".equals(action)) {
            updateBook(request, response);
        }
    }
    
    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> books = bookDAO.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/admin/books.jsp").forward(request, response);
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        List<Book> books;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            books = bookDAO.searchBooks(searchTerm.trim());
        } else {
            books = bookDAO.getAllBooks();
        }
        
        request.setAttribute("books", books);
        request.setAttribute("searchTerm", searchTerm);
        
        // Check user role and forward to appropriate page
        String role = (String) request.getSession().getAttribute("role");
        if ("STUDENT".equals(role)) {
            request.getRequestDispatcher("/student/search-books.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin/books.jsp").forward(request, response);
        }
    }
    
    private void viewBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookId = request.getParameter("id");
        if (bookId != null) {
            Book book = bookDAO.getBookById(new ObjectId(bookId));
            request.setAttribute("book", book);
        }
        request.getRequestDispatcher("/admin/book-details.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-book.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookId = request.getParameter("id");
        if (bookId != null) {
            Book book = bookDAO.getBookById(new ObjectId(bookId));
            request.setAttribute("book", book);
        }
        request.getRequestDispatcher("/admin/edit-book.jsp").forward(request, response);
    }
    
    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if ISBN already exists
            String isbn = request.getParameter("isbn");
            if (bookDAO.getBookByIsbn(isbn) != null) {
                request.setAttribute("error", "A book with this ISBN already exists");
                request.getRequestDispatcher("/admin/add-book.jsp").forward(request, response);
                return;
            }
            
            Book book = new Book();
            book.setIsbn(isbn);
            book.setTitle(request.getParameter("title"));
            book.setAuthor(request.getParameter("author"));
            book.setCategory(request.getParameter("category"));
            book.setPublisher(request.getParameter("publisher"));
            
            String publishedDateStr = request.getParameter("publishedDate");
            if (publishedDateStr != null && !publishedDateStr.isEmpty()) {
                book.setPublishedDate(dateFormat.parse(publishedDateStr));
            }
            
            int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
            book.setTotalCopies(totalCopies);
            book.setAvailableCopies(totalCopies);
            book.setDescription(request.getParameter("description"));
            
            if (bookDAO.addBook(book)) {
                request.getSession().setAttribute("success", "Book '" + book.getTitle() + "' added successfully!");
                response.sendRedirect(request.getContextPath() + "/books?action=list");
                return;
            } else {
                request.setAttribute("error", "Failed to add book");
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format for copies");
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/admin/add-book.jsp").forward(request, response);
    }
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String bookId = request.getParameter("id");
            Book book = bookDAO.getBookById(new ObjectId(bookId));
            
            if (book != null) {
                book.setTitle(request.getParameter("title"));
                book.setAuthor(request.getParameter("author"));
                book.setCategory(request.getParameter("category"));
                book.setPublisher(request.getParameter("publisher"));
                
                String publishedDateStr = request.getParameter("publishedDate");
                if (publishedDateStr != null && !publishedDateStr.isEmpty()) {
                    book.setPublishedDate(dateFormat.parse(publishedDateStr));
                }
                
                int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
                int currentAvailable = book.getAvailableCopies();
                int currentTotal = book.getTotalCopies();
                
                // Adjust available copies based on change in total copies
                book.setAvailableCopies(currentAvailable + (totalCopies - currentTotal));
                book.setTotalCopies(totalCopies);
                book.setDescription(request.getParameter("description"));
                
                if (bookDAO.updateBook(book)) {
                    request.setAttribute("success", "Book updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update book");
                }
            }
        } catch (ParseException | NumberFormatException e) {
            request.setAttribute("error", "Invalid input data: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/books?action=list");
    }
    
    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookId = request.getParameter("id");
        if (bookId != null) {
            if (bookDAO.deleteBook(new ObjectId(bookId))) {
                request.setAttribute("success", "Book deleted successfully");
            } else {
                request.setAttribute("error", "Failed to delete book");
            }
        }
        response.sendRedirect(request.getContextPath() + "/books?action=list");
    }
}