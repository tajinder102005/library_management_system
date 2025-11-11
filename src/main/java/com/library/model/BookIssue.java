package com.library.model;

import org.bson.types.ObjectId;
import java.util.Date;
import java.util.Calendar;

public class BookIssue {
    private ObjectId id;
    private ObjectId bookId;
    private ObjectId userId;
    private Date issueDate;
    private Date dueDate;
    private Date returnDate;
    private IssueStatus status;
    private String notes;
    private Date createdAt;
    
    public enum IssueStatus {
        ISSUED, RETURNED, OVERDUE, LOST
    }
    
    public BookIssue() {
        this.createdAt = new Date();
        this.issueDate = new Date();
        this.status = IssueStatus.ISSUED;
        
        // Set due date to 14 days from issue date
        Calendar cal = Calendar.getInstance();
        cal.setTime(this.issueDate);
        cal.add(Calendar.DAY_OF_MONTH, 14);
        this.dueDate = cal.getTime();
    }
    
    public BookIssue(ObjectId bookId, ObjectId userId) {
        this();
        this.bookId = bookId;
        this.userId = userId;
    }
    
    // Getters and Setters
    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }
    
    public ObjectId getBookId() { return bookId; }
    public void setBookId(ObjectId bookId) { this.bookId = bookId; }
    
    public ObjectId getUserId() { return userId; }
    public void setUserId(ObjectId userId) { this.userId = userId; }
    
    public Date getIssueDate() { return issueDate; }
    public void setIssueDate(Date issueDate) { this.issueDate = issueDate; }
    
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    
    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    
    public IssueStatus getStatus() { return status; }
    public void setStatus(IssueStatus status) { this.status = status; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public boolean isOverdue() {
        return status == IssueStatus.ISSUED && new Date().after(dueDate);
    }
    
    public long getDaysOverdue() {
        if (!isOverdue()) return 0;
        long diffInMillies = new Date().getTime() - dueDate.getTime();
        return diffInMillies / (1000 * 60 * 60 * 24);
    }
}