package com.library.dao;

import com.library.model.BookIssue;
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

public class BookIssueDAO {
    private MongoCollection<Document> collection;
    
    public BookIssueDAO() {
        this.collection = DatabaseConnection.getDatabase().getCollection("book_issues");
    }
    
    public boolean issueBook(BookIssue bookIssue) {
        try {
            Document doc = new Document("bookId", bookIssue.getBookId())
                .append("userId", bookIssue.getUserId())
                .append("issueDate", bookIssue.getIssueDate())
                .append("dueDate", bookIssue.getDueDate())
                .append("returnDate", bookIssue.getReturnDate())
                .append("status", bookIssue.getStatus().toString())
                .append("notes", bookIssue.getNotes())
                .append("createdAt", bookIssue.getCreatedAt());
            
            collection.insertOne(doc);
            bookIssue.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            System.err.println("Error issuing book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean returnBook(ObjectId issueId, String notes) {
        try {
            collection.updateOne(
                Filters.eq("_id", issueId),
                Updates.combine(
                    Updates.set("returnDate", new Date()),
                    Updates.set("status", BookIssue.IssueStatus.RETURNED.toString()),
                    Updates.set("notes", notes)
                )
            );
            return true;
        } catch (Exception e) {
            System.err.println("Error returning book: " + e.getMessage());
            return false;
        }
    }
    
    public BookIssue getIssueById(ObjectId id) {
        try {
            Document doc = collection.find(Filters.eq("_id", id)).first();
            return doc != null ? documentToBookIssue(doc) : null;
        } catch (Exception e) {
            System.err.println("Error getting issue by ID: " + e.getMessage());
            return null;
        }
    }
    
    public List<BookIssue> getIssuesByUser(ObjectId userId) {
        List<BookIssue> issues = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find(
            Filters.eq("userId", userId)).iterator()) {
            while (cursor.hasNext()) {
                issues.add(documentToBookIssue(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting issues by user: " + e.getMessage());
        }
        return issues;
    }
    
    public List<BookIssue> getActiveIssuesByUser(ObjectId userId) {
        List<BookIssue> issues = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find(
            Filters.and(
                Filters.eq("userId", userId),
                Filters.eq("status", BookIssue.IssueStatus.ISSUED.toString())
            )).iterator()) {
            while (cursor.hasNext()) {
                issues.add(documentToBookIssue(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting active issues by user: " + e.getMessage());
        }
        return issues;
    }
    
    public List<BookIssue> getOverdueIssues() {
        List<BookIssue> issues = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find(
            Filters.and(
                Filters.eq("status", BookIssue.IssueStatus.ISSUED.toString()),
                Filters.lt("dueDate", new Date())
            )).iterator()) {
            while (cursor.hasNext()) {
                issues.add(documentToBookIssue(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting overdue issues: " + e.getMessage());
        }
        return issues;
    }
    
    public List<BookIssue> getAllIssues() {
        List<BookIssue> issues = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find().iterator()) {
            while (cursor.hasNext()) {
                issues.add(documentToBookIssue(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting all issues: " + e.getMessage());
        }
        return issues;
    }
    
    public BookIssue getActiveIssueForBook(ObjectId bookId, ObjectId userId) {
        try {
            Document doc = collection.find(
                Filters.and(
                    Filters.eq("bookId", bookId),
                    Filters.eq("userId", userId),
                    Filters.eq("status", BookIssue.IssueStatus.ISSUED.toString())
                )
            ).first();
            return doc != null ? documentToBookIssue(doc) : null;
        } catch (Exception e) {
            System.err.println("Error getting active issue for book: " + e.getMessage());
            return null;
        }
    }
    
    public boolean updateIssueStatus(ObjectId issueId, BookIssue.IssueStatus status) {
        try {
            collection.updateOne(
                Filters.eq("_id", issueId),
                Updates.set("status", status.toString())
            );
            return true;
        } catch (Exception e) {
            System.err.println("Error updating issue status: " + e.getMessage());
            return false;
        }
    }
    
    private BookIssue documentToBookIssue(Document doc) {
        BookIssue issue = new BookIssue();
        issue.setId(doc.getObjectId("_id"));
        issue.setBookId(doc.getObjectId("bookId"));
        issue.setUserId(doc.getObjectId("userId"));
        issue.setIssueDate(doc.getDate("issueDate"));
        issue.setDueDate(doc.getDate("dueDate"));
        issue.setReturnDate(doc.getDate("returnDate"));
        issue.setStatus(BookIssue.IssueStatus.valueOf(doc.getString("status")));
        issue.setNotes(doc.getString("notes"));
        issue.setCreatedAt(doc.getDate("createdAt"));
        return issue;
    }
}