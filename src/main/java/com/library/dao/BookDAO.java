package com.library.dao;

import com.library.model.Book;
import com.library.util.DatabaseConnection;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

public class BookDAO {
    private MongoCollection<Document> collection;
    
    public BookDAO() {
        this.collection = DatabaseConnection.getDatabase().getCollection("books");
    }
    
    public boolean addBook(Book book) {
        try {
            Document doc = new Document("isbn", book.getIsbn())
                .append("title", book.getTitle())
                .append("author", book.getAuthor())
                .append("category", book.getCategory())
                .append("publisher", book.getPublisher())
                .append("publishedDate", book.getPublishedDate())
                .append("totalCopies", book.getTotalCopies())
                .append("availableCopies", book.getAvailableCopies())
                .append("description", book.getDescription())
                .append("createdAt", book.getCreatedAt())
                .append("updatedAt", book.getUpdatedAt());
            
            collection.insertOne(doc);
            book.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            System.err.println("Error adding book: " + e.getMessage());
            return false;
        }
    }
    
    public Book getBookById(ObjectId id) {
        try {
            Document doc = collection.find(Filters.eq("_id", id)).first();
            return doc != null ? documentToBook(doc) : null;
        } catch (Exception e) {
            System.err.println("Error getting book by ID: " + e.getMessage());
            return null;
        }
    }
    
    public Book getBookByIsbn(String isbn) {
        try {
            Document doc = collection.find(Filters.eq("isbn", isbn)).first();
            return doc != null ? documentToBook(doc) : null;
        } catch (Exception e) {
            System.err.println("Error getting book by ISBN: " + e.getMessage());
            return null;
        }
    }
    
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find().iterator()) {
            while (cursor.hasNext()) {
                books.add(documentToBook(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting all books: " + e.getMessage());
        }
        return books;
    }
    
    public List<Book> searchBooks(String searchTerm) {
        List<Book> books = new ArrayList<>();
        try {
            Pattern pattern = Pattern.compile(searchTerm, Pattern.CASE_INSENSITIVE);
            Document query = new Document("$or", List.of(
                new Document("title", pattern),
                new Document("author", pattern),
                new Document("isbn", pattern),
                new Document("category", pattern)
            ));
            
            try (MongoCursor<Document> cursor = collection.find(query).iterator()) {
                while (cursor.hasNext()) {
                    books.add(documentToBook(cursor.next()));
                }
            }
        } catch (Exception e) {
            System.err.println("Error searching books: " + e.getMessage());
        }
        return books;
    }
    
    public boolean updateBook(Book book) {
        try {
            book.setUpdatedAt(new Date());
            collection.updateOne(
                Filters.eq("_id", book.getId()),
                Updates.combine(
                    Updates.set("title", book.getTitle()),
                    Updates.set("author", book.getAuthor()),
                    Updates.set("category", book.getCategory()),
                    Updates.set("publisher", book.getPublisher()),
                    Updates.set("publishedDate", book.getPublishedDate()),
                    Updates.set("totalCopies", book.getTotalCopies()),
                    Updates.set("availableCopies", book.getAvailableCopies()),
                    Updates.set("description", book.getDescription()),
                    Updates.set("updatedAt", book.getUpdatedAt())
                )
            );
            return true;
        } catch (Exception e) {
            System.err.println("Error updating book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBook(ObjectId id) {
        try {
            collection.deleteOne(Filters.eq("_id", id));
            return true;
        } catch (Exception e) {
            System.err.println("Error deleting book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateAvailableCopies(ObjectId bookId, int change) {
        try {
            collection.updateOne(
                Filters.eq("_id", bookId),
                Updates.combine(
                    Updates.inc("availableCopies", change),
                    Updates.set("updatedAt", new Date())
                )
            );
            return true;
        } catch (Exception e) {
            System.err.println("Error updating available copies: " + e.getMessage());
            return false;
        }
    }
    
    private Book documentToBook(Document doc) {
        Book book = new Book();
        book.setId(doc.getObjectId("_id"));
        book.setIsbn(doc.getString("isbn"));
        book.setTitle(doc.getString("title"));
        book.setAuthor(doc.getString("author"));
        book.setCategory(doc.getString("category"));
        book.setPublisher(doc.getString("publisher"));
        book.setPublishedDate(doc.getDate("publishedDate"));
        book.setTotalCopies(doc.getInteger("totalCopies", 0));
        book.setAvailableCopies(doc.getInteger("availableCopies", 0));
        book.setDescription(doc.getString("description"));
        book.setCreatedAt(doc.getDate("createdAt"));
        book.setUpdatedAt(doc.getDate("updatedAt"));
        return book;
    }
}