<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Issues - Library Management System</title>
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
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books?action=list">
                                <i class="fas fa-book"></i> Manage Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/issues?action=list">
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
                    <h1 class="h2">Book Issues</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="../issues?action=issue" class="btn btn-primary me-2">
                            <i class="fas fa-plus"></i> Issue Book
                        </a>
                        <a href="../issues?action=return" class="btn btn-success me-2">
                            <i class="fas fa-undo"></i> Return Book
                        </a>
                        <a href="../issues?action=overdue" class="btn btn-warning">
                            <i class="fas fa-exclamation-triangle"></i> Overdue
                        </a>
                    </div>
                </div>

                <!-- Issues Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">All Book Issues</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Book Title</th>
                                        <th>Student Name</th>
                                        <th>Issue Date</th>
                                        <th>Due Date</th>
                                        <th>Return Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty issues}">
                                            <c:forEach var="issueDetail" items="${issues}">
                                                <c:set var="issue" value="${issueDetail.issue}" />
                                                <c:set var="book" value="${issueDetail.book}" />
                                                <c:set var="user" value="${issueDetail.user}" />
                                                <tr>
                                                    <td>
                                                        <strong>${book.title}</strong>
                                                        <br><small class="text-muted">ISBN: ${book.isbn}</small>
                                                    </td>
                                                    <td>${user.fullName}</td>
                                                    <td><fmt:formatDate value="${issue.issueDate}" pattern="MMM dd, yyyy" /></td>
                                                    <td><fmt:formatDate value="${issue.dueDate}" pattern="MMM dd, yyyy" /></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${issue.returnDate != null}">
                                                                <fmt:formatDate value="${issue.returnDate}" pattern="MMM dd, yyyy" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Not returned</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${issue.status == 'ISSUED'}">
                                                                <span class="badge bg-primary">Issued</span>
                                                            </c:when>
                                                            <c:when test="${issue.status == 'RETURNED'}">
                                                                <span class="badge bg-success">Returned</span>
                                                            </c:when>
                                                            <c:when test="${issue.status == 'OVERDUE'}">
                                                                <span class="badge bg-danger">Overdue</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">${issue.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="text-center py-4">
                                                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                                    <p class="text-muted">No book issues found</p>
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