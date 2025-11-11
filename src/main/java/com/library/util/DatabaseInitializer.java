package com.library.util;

import com.library.dao.UserDAO;
import com.library.dao.BookDAO;
import com.library.model.User;
import com.library.model.Book;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Date;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initializing Library Management System...");
        
        // Test database connection
        if (DatabaseConnection.testConnection()) {
            System.out.println("Database connection successful");
            initializeDefaultData();
        } else {
            System.err.println("Database connection failed!");
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DatabaseConnection.closeConnection();
        System.out.println("Library Management System shutdown complete");
    }
    
    private void initializeDefaultData() {
        UserDAO userDAO = new UserDAO();
        BookDAO bookDAO = new BookDAO();
        
        // Create default admin user if not exists
        if (userDAO.getUserByUsername("admin") == null) {
            User admin = new User("admin", "admin123", "admin@library.com", 
                                "System Administrator", User.UserRole.ADMIN);
            admin.setPhone("123-456-7890");
            admin.setAddress("Library Administration Office");
            
            if (userDAO.addUser(admin)) {
                System.out.println("Default admin user created: admin/admin123");
            }
        }
        
        // Create default librarian user if not exists
        if (userDAO.getUserByUsername("librarian") == null) {
            User librarian = new User("librarian", "lib123", "librarian@library.com", 
                                    "Head Librarian", User.UserRole.LIBRARIAN);
            librarian.setPhone("123-456-7891");
            librarian.setAddress("Library Main Desk");
            
            if (userDAO.addUser(librarian)) {
                System.out.println("Default librarian user created: librarian/lib123");
            }
        }
        
        // Create default student user if not exists
        if (userDAO.getUserByUsername("student") == null) {
            User student = new User("student", "student123", "student@university.edu", 
                                  "John Doe", User.UserRole.STUDENT);
            student.setPhone("123-456-7892");
            student.setAddress("Student Dormitory");
            
            if (userDAO.addUser(student)) {
                System.out.println("Default student user created: student/student123");
            }
        }
        
        // Add sample books if collection is empty
        if (bookDAO.getAllBooks().isEmpty()) {
            addSampleBooks(bookDAO);
        }
    }
    
    private void addSampleBooks(BookDAO bookDAO) {
        Book[] sampleBooks = {
            new Book("978-0134685991", "Effective Java", "Joshua Bloch", "Technology", "Addison-Wesley", 3),
            new Book("978-0596009205", "Head First Design Patterns", "Eric Freeman", "Technology", "O'Reilly Media", 2),
            new Book("978-0321356680", "Effective C++", "Scott Meyers", "Technology", "Addison-Wesley", 2),
            new Book("978-0132350884", "Clean Code", "Robert C. Martin", "Technology", "Prentice Hall", 4),
            new Book("978-0201633610", "Design Patterns", "Gang of Four", "Technology", "Addison-Wesley", 2),
            new Book("978-0132181273", "Domain-Driven Design", "Eric Evans", "Technology", "Addison-Wesley", 1),
            new Book("978-0321125217", "The Pragmatic Programmer", "Andrew Hunt", "Technology", "Addison-Wesley", 3),
            new Book("978-0134494166", "Clean Architecture", "Robert C. Martin", "Technology", "Prentice Hall", 2),
            new Book("978-1617294945", "Spring in Action", "Craig Walls", "Technology", "Manning Publications", 2),
            new Book("978-0596007126", "Head First Java", "Kathy Sierra", "Technology", "O'Reilly Media", 3)
        };
        
        for (Book book : sampleBooks) {
            book.setDescription("Sample book for library management system");
            book.setPublishedDate(new Date());
            
            if (bookDAO.addBook(book)) {
                System.out.println("Added sample book: " + book.getTitle());
            }
        }
        
        System.out.println("Sample books added to the library");
    }
}