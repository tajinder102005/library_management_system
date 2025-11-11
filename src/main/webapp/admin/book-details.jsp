<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>.sidebar{min-height:100vh;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%)}</style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4"><h4><i class="fas fa-book"></i> Library Admin</h4><p>Welcome, ${sessionScope.username}</p></div>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link text-white active" href="${pageContext.request.contextPath}/books?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/issues?action=list"><i class="fas fa-exchange-alt"></i> Book Issues</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/users?action=list"><i class="fas fa-users"></i> Manage Users</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
                        <li class="nav-item mt-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Book Details</h1>
                    <a href="${pageContext.request.contextPath}/books?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
                <c:if test="${not empty book}">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header"><h5>${book.title}</h5></div>
                                <div class="card-body">
                                    <table class="table">
                                        <tr><th width="30%">ISBN:</th><td>${book.isbn}</td></tr>
                                        <tr><th>Title:</th><td><strong>${book.title}</strong></td></tr>
                                        <tr><th>Author:</th><td>${book.author}</td></tr>
                                        <tr><th>Category:</th><td><span class="badge bg-secondary">${book.category}</span></td></tr>
                                        <tr><th>Publisher:</th><td>${book.publisher}</td></tr>
                                        <tr><th>Published Date:</th><td><fmt:formatDate value="${book.publishedDate}" pattern="MMM dd, yyyy"/></td></tr>
                                        <tr><th>Total Copies:</th><td>${book.totalCopies}</td></tr>
                                        <tr><th>Available Copies:</th><td><span class="badge bg-${book.availableCopies > 0 ? 'success' : 'danger'}">${book.availableCopies}</span></td></tr>
                                        <tr><th>Description:</th><td>${book.description}</td></tr>
                                    </table>
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/books?action=edit&id=${book.id}" class="btn btn-primary"><i class="fas fa-edit"></i> Edit</a>
                                        <a href="${pageContext.request.contextPath}/books?action=delete&id=${book.id}" class="btn btn-danger" onclick="return confirm('Delete this book?')"><i class="fas fa-trash"></i> Delete</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header"><h6>Status</h6></div>
                                <div class="card-body text-center">
                                    <c:choose>
                                        <c:when test="${book.availableCopies > 0}">
                                            <i class="fas fa-check-circle fa-4x text-success mb-3"></i>
                                            <h5 class="text-success">Available</h5>
                                            <p>${book.availableCopies} of ${book.totalCopies} copies available</p>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-times-circle fa-4x text-danger mb-3"></i>
                                            <h5 class="text-danger">Out of Stock</h5>
                                            <p>All ${book.totalCopies} copies are currently issued</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>