package com.library.model;

import org.bson.types.ObjectId;
import java.util.Date;

public class User {
    private ObjectId id;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private String address;
    private UserRole role;
    private boolean active;
    private Date createdAt;
    private Date updatedAt;
    
    public enum UserRole {
        STUDENT, LIBRARIAN, ADMIN
    }
    
    public User() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
        this.active = true;
    }
    
    public User(String username, String password, String email, String fullName, UserRole role) {
        this();
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.role = role;
    }
    
    // Getters and Setters
    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public UserRole getRole() { return role; }
    public void setRole(UserRole role) { this.role = role; }
    
    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    
    public boolean isLibrarian() {
        return role == UserRole.LIBRARIAN || role == UserRole.ADMIN;
    }
}