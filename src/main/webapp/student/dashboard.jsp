<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.library.dao.*" %>
<%@ page import="com.library.model.*" %>
<%@ page import="org.bson.types.ObjectId" %>
<%@ page import="java.util.*" %>

<%
    // Get user's issued books
    String userIdStr = (String) session.getAttribute("userId");
    if (userIdStr != null) {
        BookIssueDAO issueDAO = new BookIssueDAO();
        BookDAO bookDAO = new BookDAO();
        
        ObjectId userId = new ObjectId(userIdStr);
        List<BookIssue> userIssues = issueDAO.getActiveIssuesByUser(userId);
        List<BookIssue> userHistory = issueDAO.getIssuesByUser(userId);
        
        // Get book details for issued books
        List<Map<String, Object>> issuedBooksWithDetails = new ArrayList<Map<String, Object>>();
        for (BookIssue issue : userIssues) {
            Book book = bookDAO.getBookById(issue.getBookId());
            if (book != null) {
                Map<String, Object> bookIssue = new HashMap<String, Object>();
                bookIssue.put("issue", issue);
                bookIssue.put("book", book);
                issuedBooksWithDetails.add(bookIssue);
            }
        }
        
        request.setAttribute("issuedBooks", issuedBooksWithDetails);
        request.setAttribute("totalIssued", userIssues.size());
        request.setAttribute("totalHistory", userHistory.size());
        
        // Count overdue books
        int overdueCount = 0;
        for (BookIssue issue : userIssues) {
            if (issue.isOverdue()) {
                overdueCount++;
            }
        }
        request.setAttribute("overdueCount", overdueCount);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }
        .stat-card {
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .overdue {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
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
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/student/dashboard.jsp">
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books?action=search">
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
                    <h1 class="h2">My Dashboard</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-calendar"></i> Today
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Currently Issued
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalIssued}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-book-reader fa-2x text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Total Borrowed
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalHistory}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-history fa-2x text-success"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Overdue Books
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${overdueCount}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-exclamation-triangle fa-2x text-warning"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Available Slots
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${5 - totalIssued}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-plus-circle fa-2x text-info"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-2">
                                        <a href="../books?action=search" class="btn btn-primary btn-block w-100">
                                            <i class="fas fa-search"></i> Search Books
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="my-books.jsp" class="btn btn-success btn-block w-100">
                                            <i class="fas fa-book-reader"></i> My Books
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="history.jsp" class="btn btn-info btn-block w-100">
                                            <i class="fas fa-history"></i> View History
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="profile.jsp" class="btn btn-secondary btn-block w-100">
                                            <i class="fas fa-user"></i> My Profile
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Currently Issued Books -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Currently Issued Books</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty issuedBooks}">
                                        <div class="table-responsive">
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Book Title</th>
                                                        <th>Author</th>
                                                        <th>Issue Date</th>
                                                        <th>Due Date</th>
                                                        <th>Status</th>
                                                        <th>Days Left</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="bookIssue" items="${issuedBooks}">
                                                        <c:set var="issue" value="${bookIssue.issue}" />
                                                        <c:set var="book" value="${bookIssue.book}" />
                                                        <c:set var="isOverdue" value="${issue.overdue}" />
                                                        
                                                        <tr class="${isOverdue ? 'overdue' : ''}">
                                                            <td>
                                                                <strong>${book.title}</strong>
                                                                <br><small class="text-muted">ISBN: ${book.isbn}</small>
                                                            </td>
                                                            <td>${book.author}</td>
                                                            <td>
                                                                <fmt:formatDate value="${issue.issueDate}" pattern="MMM dd, yyyy" />
                                                            </td>
                                                            <td>
                                                                <fmt:formatDate value="${issue.dueDate}" pattern="MMM dd, yyyy" />
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${isOverdue}">
                                                                        <span class="badge bg-danger">Overdue</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-success">Active</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${isOverdue}">
                                                                        <span class="text-danger">
                                                                            ${issue.daysOverdue} days overdue
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:set var="daysLeft" value="${(issue.dueDate.time - now.time) / (1000 * 60 * 60 * 24)}" />
                                                                        <span class="text-success">
                                                                            ${Math.floor(daysLeft)} days left
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">You don't have any books currently issued.</p>
                                            <a href="../books?action=search" class="btn btn-primary">
                                                <i class="fas fa-search"></i> Browse Books
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>