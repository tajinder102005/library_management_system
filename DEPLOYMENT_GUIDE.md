# Library Management System - Deployment Guide

## Prerequisites
- Java 11 or higher
- Maven 3.6+
- MongoDB 4.0+ (running on localhost:27017)

## Quick Start

### 1. Start MongoDB
Ensure MongoDB is running on `localhost:27017`

### 2. Build and Run
```bash
mvn clean tomcat7:run
```

The application will start on `http://localhost:8080`

## Default Login Credentials

### Admin/Librarian
- **Username:** `admin`
- **Password:** `admin123`

OR

- **Username:** `librarian`
- **Password:** `lib123`

### Student
- **Username:** `student`
- **Password:** `student123`

## Features

### Admin/Librarian Features
- Dashboard with statistics
- Book Management (Add, Edit, Delete, Search)
- Issue Books to Students
- Return Books
- View Overdue Books
- User Management
- Reports and Analytics

### Student Features
- Personal Dashboard
- Search Books
- View Currently Issued Books
- View Borrowing History
- View Profile

## Application Structure

```
/                       - Home page
/login                  - Login page
/logout                 - Logout

Admin Pages:
/admin/dashboard.jsp    - Admin dashboard
/books?action=list      - Manage books
/issues?action=list     - Book issues
/users?action=list      - Manage users
/reports                - Reports

Student Pages:
/student/dashboard.jsp  - Student dashboard
/books?action=search    - Search books
/student/my-books.jsp   - My issued books
/student/history.jsp    - Borrowing history
/student/profile.jsp    - My profile
```

## Database

The application automatically creates:
- Database: `library_management`
- Collections: `books`, `users`, `book_issues`, `fines`
- Sample data: 10 books and 3 default users

## Configuration

Database configuration can be modified in:
`src/main/resources/database-config.xml`

## Troubleshooting

### MongoDB Connection Issues
- Ensure MongoDB is running: `mongod --version`
- Check connection string in `database-config.xml`

### Port Already in Use
- Change port in `pom.xml` under tomcat7-maven-plugin configuration
- Default port: 8080

### Build Issues
- Clean Maven cache: `mvn clean`
- Update dependencies: `mvn dependency:resolve`

## Technology Stack
- **Backend:** Java 11, Servlets, JSP
- **Database:** MongoDB 4.9.1
- **Frontend:** Bootstrap 5, Font Awesome 6
- **Build Tool:** Maven
- **Server:** Embedded Tomcat 7

## Support
For issues or questions, check the README.md file for detailed documentation.