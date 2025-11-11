<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Books - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4">
                        <h4><i class="fas fa-book"></i> Library Admin</h4>
                        <p>Welcome, ${sessionScope.username}</p>
                    </div>
                    
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/books?action=list">
                                <i class="fas fa-book"></i> Manage Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/issues?action=list">
                                <i class="fas fa-exchange-alt"></i> Book Issues
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/users?action=list">
                                <i class="fas fa-users"></i> Manage Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/reports">
                                <i class="fas fa-chart-bar"></i> Reports
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Manage Books</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="../books?action=add" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New Book
                        </a>
                    </div>
                </div>

                <!-- Search Form -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <form action="../books" method="get" class="row g-3">
                                    <input type="hidden" name="action" value="search">
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="search" 
                                               placeholder="Search by title, author, ISBN, or category..."
                                               value="${searchTerm}">
                                    </div>
                                    <div class="col-md-4">
                                        <button type="submit" class="btn btn-outline-primary">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                        <a href="../books?action=list" class="btn btn-outline-secondary">
                                            <i class="fas fa-refresh"></i> Clear
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${sessionScope.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Books Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Book Collection</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ISBN</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Category</th>
                                        <th>Total Copies</th>
                                        <th>Available</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty books}">
                                            <c:forEach var="book" items="${books}">
                                                <tr>
                                                    <td>${book.isbn}</td>
                                                    <td>
                                                        <strong>${book.title}</strong>
                                                        <c:if test="${not empty book.publisher}">
                                                            <br><small class="text-muted">${book.publisher}</small>
                                                        </c:if>
                                                    </td>
                                                    <td>${book.author}</td>
                                                    <td>
                                                        <span class="badge bg-secondary">${book.category}</span>
                                                    </td>
                                                    <td>${book.totalCopies}</td>
                                                    <td>${book.availableCopies}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${book.availableCopies > 0}">
                                                                <span class="badge bg-success">Available</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Out of Stock</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="../books?action=view&id=${book.id}" 
                                                               class="btn btn-sm btn-outline-info" title="View Details">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="../books?action=edit&id=${book.id}" 
                                                               class="btn btn-sm btn-outline-primary" title="Edit">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="../books?action=delete&id=${book.id}" 
                                                               class="btn btn-sm btn-outline-danger" title="Delete"
                                                               onclick="return confirm('Are you sure you want to delete this book?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center py-4">
                                                    <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                                    <p class="text-muted">No books found. <a href="../books?action=add">Add your first book</a></p>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>