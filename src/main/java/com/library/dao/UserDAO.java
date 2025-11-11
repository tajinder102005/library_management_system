package com.library.dao;

import com.library.model.User;
import com.library.util.DatabaseConnection;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDAO {
    private MongoCollection<Document> collection;
    
    public UserDAO() {
        this.collection = DatabaseConnection.getDatabase().getCollection("users");
    }
    
    public boolean addUser(User user) {
        try {
            // Hash password before storing
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            
            Document doc = new Document("username", user.getUsername())
                .append("password", hashedPassword)
                .append("email", user.getEmail())
                .append("fullName", user.getFullName())
                .append("phone", user.getPhone())
                .append("address", user.getAddress())
                .append("role", user.getRole().toString())
                .append("active", user.isActive())
                .append("createdAt", user.getCreatedAt())
                .append("updatedAt", user.getUpdatedAt());
            
            collection.insertOne(doc);
            user.setId(doc.getObjectId("_id"));
            return true;
        } catch (Exception e) {
            System.err.println("Error adding user: " + e.getMessage());
            return false;
        }
    }
    
    public User getUserById(ObjectId id) {
        try {
            Document doc = collection.find(Filters.eq("_id", id)).first();
            return doc != null ? documentToUser(doc) : null;
        } catch (Exception e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            return null;
        }
    }
    
    public User getUserByUsername(String username) {
        try {
            Document doc = collection.find(Filters.eq("username", username)).first();
            return doc != null ? documentToUser(doc) : null;
        } catch (Exception e) {
            System.err.println("Error getting user by username: " + e.getMessage());
            return null;
        }
    }
    
    public User authenticateUser(String username, String password) {
        try {
            User user = getUserByUsername(username);
            if (user != null && user.isActive() && 
                BCrypt.checkpw(password, user.getPassword())) {
                return user;
            }
        } catch (Exception e) {
            System.err.println("Error authenticating user: " + e.getMessage());
        }
        return null;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find().iterator()) {
            while (cursor.hasNext()) {
                users.add(documentToUser(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting all users: " + e.getMessage());
        }
        return users;
    }
    
    public List<User> getStudents() {
        List<User> students = new ArrayList<>();
        try (MongoCursor<Document> cursor = collection.find(
            Filters.eq("role", "STUDENT")).iterator()) {
            while (cursor.hasNext()) {
                students.add(documentToUser(cursor.next()));
            }
        } catch (Exception e) {
            System.err.println("Error getting students: " + e.getMessage());
        }
        return students;
    }
    
    public boolean updateUser(User user) {
        try {
            user.setUpdatedAt(new Date());
            collection.updateOne(
                Filters.eq("_id", user.getId()),
                Updates.combine(
                    Updates.set("email", user.getEmail()),
                    Updates.set("fullName", user.getFullName()),
                    Updates.set("phone", user.getPhone()),
                    Updates.set("address", user.getAddress()),
                    Updates.set("role", user.getRole().toString()),
                    Updates.set("active", user.isActive()),
                    Updates.set("updatedAt", user.getUpdatedAt())
                )
            );
            return true;
        } catch (Exception e) {
            System.err.println("Error updating user: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updatePassword(ObjectId userId, String newPassword) {
        try {
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            collection.updateOne(
                Filters.eq("_id", userId),
                Updates.combine(
                    Updates.set("password", hashedPassword),
                    Updates.set("updatedAt", new Date())
                )
            );
            return true;
        } catch (Exception e) {
            System.err.println("Error updating password: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteUser(ObjectId id) {
        try {
            collection.deleteOne(Filters.eq("_id", id));
            return true;
        } catch (Exception e) {
            System.err.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }
    
    private User documentToUser(Document doc) {
        User user = new User();
        user.setId(doc.getObjectId("_id"));
        user.setUsername(doc.getString("username"));
        user.setPassword(doc.getString("password"));
        user.setEmail(doc.getString("email"));
        user.setFullName(doc.getString("fullName"));
        user.setPhone(doc.getString("phone"));
        user.setAddress(doc.getString("address"));
        user.setRole(User.UserRole.valueOf(doc.getString("role")));
        user.setActive(doc.getBoolean("active", true));
        user.setCreatedAt(doc.getDate("createdAt"));
        user.setUpdatedAt(doc.getDate("updatedAt"));
        return user;
    }
}