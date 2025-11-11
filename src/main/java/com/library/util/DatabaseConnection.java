package com.library.util;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.InputStream;

public class DatabaseConnection {
    private static MongoClient mongoClient;
    private static MongoDatabase database;
    private static String connectionString;
    private static String databaseName;
    
    static {
        loadConfiguration();
        initializeConnection();
    }
    
    private static void loadConfiguration() {
        try {
            InputStream inputStream = DatabaseConnection.class
                .getClassLoader().getResourceAsStream("database-config.xml");
            
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(inputStream);
            
            Element mongoElement = (Element) doc.getElementsByTagName("mongodb").item(0);
            connectionString = mongoElement.getElementsByTagName("connection-string")
                .item(0).getTextContent();
            databaseName = mongoElement.getElementsByTagName("database-name")
                .item(0).getTextContent();
                
        } catch (Exception e) {
            // Fallback to default values
            connectionString = "mongodb://localhost:27017";
            databaseName = "library_management";
            System.err.println("Error loading database configuration: " + e.getMessage());
        }
    }
    
    private static void initializeConnection() {
        try {
            mongoClient = MongoClients.create(connectionString);
            database = mongoClient.getDatabase(databaseName);
            System.out.println("Connected to MongoDB: " + databaseName);
        } catch (Exception e) {
            System.err.println("Failed to connect to MongoDB: " + e.getMessage());
            throw new RuntimeException("Database connection failed", e);
        }
    }
    
    public static MongoDatabase getDatabase() {
        if (database == null) {
            initializeConnection();
        }
        return database;
    }
    
    public static void closeConnection() {
        if (mongoClient != null) {
            mongoClient.close();
            System.out.println("MongoDB connection closed");
        }
    }
    
    // Test connection method
    public static boolean testConnection() {
        try {
            database.runCommand(new org.bson.Document("ping", 1));
            return true;
        } catch (Exception e) {
            System.err.println("Database connection test failed: " + e.getMessage());
            return false;
        }
    }
}