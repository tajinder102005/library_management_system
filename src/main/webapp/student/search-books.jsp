<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Books - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }
        .book-card {
            transition: transform 0.3s;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
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
                        <h4><i class="fas fa-user-graduate"></i> Student Portal</h4>
                        <p>Welcome, ${sessionScope.username}</p>
                    </div>
                    
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/student/dashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/books?action=search">
                                <i class="fas fa-search"></i> Search Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/student/my-books.jsp">
                                <i class="fas fa-book-reader"></i> My Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/student/history.jsp">
                                <i class="fas fa-history"></i> Borrowing History
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/student/profile.jsp">
                                <i class="fas fa-user"></i> My Profile
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
                    <h1 class="h2">Search Books</h1>
                </div>

                <!-- Search Form -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/books" method="get" class="row g-3">
                                    <input type="hidden" name="action" value="search">
                                    <div class="col-md-10">
                                        <input type="text" class="form-control form-control-lg" name="search" 
                                               placeholder="Search by title, author, ISBN, or category..."
                                               value="${searchTerm}">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary btn-lg w-100">
                                            <i class="fas fa-search"></i> Search
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Books Grid -->
                <div class="row">
                    <c:choose>
                        <c:when test="${not empty books}">
                            <c:forEach var="book" items="${books}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card book-card h-100">
                                        <div class="card-body">
                                            <h5 class="card-title">${book.title}</h5>
                                            <h6 class="card-subtitle mb-2 text-muted">${book.author}</h6>
                                            <p class="card-text">
                                                <small>
                                                    <strong>ISBN:</strong> ${book.isbn}<br>
                                                    <strong>Category:</strong> <span class="badge bg-secondary">${book.category}</span><br>
                                                    <strong>Publisher:</strong> ${book.publisher}<br>
                                                    <strong>Available:</strong> 
                                                    <c:choose>
                                                        <c:when test="${book.availableCopies > 0}">
                                                            <span class="badge bg-success">${book.availableCopies} copies</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Out of stock</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </p>
                                            <c:if test="${not empty book.description}">
                                                <p class="card-text"><small class="text-muted">${book.description}</small></p>
                                            </c:if>
                                        </div>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${book.availableCopies > 0}">
                                                    <span class="text-success">
                                                        <i class="fas fa-check-circle"></i> Available for borrowing
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger">
                                                        <i class="fas fa-times-circle"></i> Currently unavailable
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="text-center py-5">
                                    <i class="fas fa-search fa-4x text-muted mb-3"></i>
                                    <h3 class="text-muted">No books found</h3>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty searchTerm}">
                                                Try searching with different keywords
                                            </c:when>
                                            <c:otherwise>
                                                Start searching to find books
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>