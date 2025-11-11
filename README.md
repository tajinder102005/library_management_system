# Library Book Management System

A comprehensive web-based Library Management System built with Java, JSP, XML configuration, and MongoDB. This system streamlines library operations by automating book catalog management, issuance tracking, user management, and reporting.

## Features

### Core Functionality
- **Book Catalog Management**: Add, update, delete, and search books with detailed information
- **User Authentication**: Secure login system with role-based access (Admin, Librarian, Student)
- **Book Issuance & Return**: Track book borrowing with automatic due date calculation
- **Overdue Management**: Automatic overdue detection with fine calculation
- **Search & Filter**: Advanced search by title, author, ISBN, or category
- **Reports & Analytics**: Comprehensive reporting on library operations

### User Roles
- **Admin/Librarian**: Full system access including book management, user management, and reports
- **Student**: Book search, view issued books, borrowing history, and profile management

### Technical Features
- **MongoDB Integration**: NoSQL database for scalable data storage
- **XML Configuration**: Database and application configuration via XML files
- **Responsive Design**: Bootstrap-based UI that works on all devices
- **Security**: Password hashing with BCrypt and session management
- **RESTful Architecture**: Clean servlet-based architecture

## Technology Stack

- **Backend**: Java 11, Servlets, JSP
- **Database**: MongoDB with Java Driver
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Build Tool**: Maven
- **Security**: BCrypt for password hashing
- **Server**: Any Java EE compatible server (Tomcat, Jetty, etc.)

## Project Structure

```
library-management-system/
├── src/main/java/com/library/
│   ├── dao/                    # Data Access Objects
│   ├── model/                  # Entity classes
│   ├── servlet/                # HTTP Servlets
│   └── util/                   # Utility classes
├── src/main/resources/         # Configuration files
├── src/main/webapp/            # Web application files
│   ├── admin/                  # Admin/Librarian pages
│   ├── student/                # Student pages
│   ├── error/                  # Error pages
│   └── WEB-INF/               # Web configuration
└── pom.xml                     # Maven configuration
```

## Installation & Setup

### Prerequisites
- Java 11 or higher
- Maven 3.6+
- MongoDB 4.0+
- Java EE compatible web server (Tomcat 9+)

### Database Setup
1. Install and start MongoDB
2. The application will automatically create the required database and collections
3. Default database name: `library_management`

### Application Setup
1. Clone the repository
2. Configure MongoDB connection in `src/main/resources/database-config.xml`
3. Build the project: `mvn clean package`
4. Deploy the generated WAR file to your web server
5. Access the application at `http://localhost:8080/library-management-system`

### Default Users
The system creates default users on first startup:
- **Admin**: username: `admin`, password: `admin123`
- **Librarian**: username: `librarian`, password: `lib123`
- **Student**: username: `student`, password: `student123`

## Configuration

### Database Configuration
Edit `src/main/resources/database-config.xml`:
```xml
<database-config>
    <mongodb>
        <connection-string>mongodb://localhost:27017</connection-string>
        <database-name>library_management</database-name>
        <!-- Additional configuration options -->
    </mongodb>
</database-config>
```

### Web Configuration
The `web.xml` file contains servlet mappings, security constraints, and error page configurations.

## Usage

### For Librarians/Admins
1. Login with librarian credentials
2. Access admin dashboard for system overview
3. Manage books: Add, edit, delete, and search books
4. Handle book issues and returns
5. Manage user accounts
6. Generate reports and analytics

### For Students
1. Login with student credentials
2. Search and browse available books
3. View currently issued books and due dates
4. Check borrowing history
5. Update profile information

## API Endpoints

### Book Management
- `GET /books?action=list` - List all books
- `GET /books?action=search&search=term` - Search books
- `POST /books?action=add` - Add new book
- `POST /books?action=update` - Update book
- `GET /books?action=delete&id=bookId` - Delete book

### User Management
- `POST /login` - User authentication
- `GET /logout` - User logout
- `GET /users?action=list` - List users (admin only)

### Book Issues
- `POST /issues?action=issue` - Issue book
- `POST /issues?action=return` - Return book
- `GET /issues?action=overdue` - Get overdue books

## Database Schema

### Collections
- **books**: Book catalog information
- **users**: User accounts and profiles
- **book_issues**: Book issuance records
- **fines**: Fine calculation records (future enhancement)

### Key Fields
- Books: ISBN, title, author, category, copies, availability
- Users: username, password (hashed), role, contact info
- Issues: book ID, user ID, issue date, due date, status

## Security Features

- Password hashing using BCrypt
- Session-based authentication
- Role-based access control
- SQL injection prevention through parameterized queries
- XSS protection in JSP pages

## Future Enhancements

- Email notifications for due dates and overdue books
- Fine calculation and payment tracking
- Book reservation system
- Mobile application
- Advanced reporting with charts
- Integration with library card systems
- Barcode scanning support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the documentation in the `/docs` folder
- Review the sample data and configurations

## Acknowledgments

- MongoDB Java Driver documentation
- Bootstrap framework for responsive design
- Font Awesome for icons
- Java EE community for best practices