<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
        }
        .feature-card {
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-book"></i> Library Management System
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="login.jsp">Login</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 mb-4">Welcome to Library Management System</h1>
            <p class="lead mb-4">Streamline your library operations with our comprehensive book management solution</p>
            <a href="login.jsp" class="btn btn-light btn-lg">Get Started</a>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col">
                    <h2>Key Features</h2>
                    <p class="text-muted">Everything you need to manage your library efficiently</p>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-books fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Book Catalog Management</h5>
                            <p class="card-text">Add, update, and organize your book collection with detailed information including ISBN, author, category, and availability.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                            <h5 class="card-title">Issue & Return Tracking</h5>
                            <p class="card-text">Track book issuance and returns with automatic due date calculation and return status management.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Overdue Management</h5>
                            <p class="card-text">Automatic overdue detection with fine calculation and notification system for timely returns.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-users fa-3x text-info mb-3"></i>
                            <h5 class="card-title">User Management</h5>
                            <p class="card-text">Secure authentication with role-based access for librarians and students with different privileges.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-search fa-3x text-secondary mb-3"></i>
                            <h5 class="card-title">Advanced Search</h5>
                            <p class="card-text">Quick search and filter books by title, author, ISBN, or category for easy book discovery.</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-chart-bar fa-3x text-danger mb-3"></i>
                            <h5 class="card-title">Reports & Analytics</h5>
                            <p class="card-text">Generate comprehensive reports on book availability, user activity, and overdue items.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2024 Library Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>