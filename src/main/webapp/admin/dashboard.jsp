<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.library.dao.*" %>
<%@ page import="com.library.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Get statistics for dashboard
    BookDAO bookDAO = new BookDAO();
    UserDAO userDAO = new UserDAO();
    BookIssueDAO issueDAO = new BookIssueDAO();
    
    List<Book> allBooks = bookDAO.getAllBooks();
    List<User> allStudents = userDAO.getStudents();
    List<BookIssue> overdueIssues = issueDAO.getOverdueIssues();
    List<BookIssue> allIssues = issueDAO.getAllIssues();
    
    int totalBooks = allBooks.size();
    
    // Calculate available books
    int availableBooks = 0;
    for (Book book : allBooks) {
        availableBooks += book.getAvailableCopies();
    }
    
    // Count issued books
    int issuedBooks = 0;
    for (BookIssue issue : allIssues) {
        if (issue.getStatus() == BookIssue.IssueStatus.ISSUED) {
            issuedBooks++;
        }
    }
    
    int totalStudents = allStudents.size();
    int overdueCount = overdueIssues.size();
    
    request.setAttribute("totalBooks", totalBooks);
    request.setAttribute("availableBooks", availableBooks);
    request.setAttribute("issuedBooks", issuedBooks);
    request.setAttribute("totalStudents", totalStudents);
    request.setAttribute("overdueCount", overdueCount);
    
    // Get recent issues (max 5)
    int recentCount = Math.min(5, allIssues.size());
    List<BookIssue> recentIssues = new ArrayList<BookIssue>();
    for (int i = 0; i < recentCount; i++) {
        recentIssues.add(allIssues.get(i));
    }
    request.setAttribute("recentIssues", recentIssues);
%></recentCount>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .stat-card {
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
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
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/admin/dashboard.jsp"></a>
                                <i class="fas fa-tachometer-alt"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books?action=list">
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
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"></a>
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
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
                                            Total Books
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalBooks}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-book fa-2x text-primary"></i>
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
                                            Available Books
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${availableBooks}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-check-circle fa-2x text-success"></i>
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
                                            Issued Books
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${issuedBooks}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-hand-holding fa-2x text-info"></i>
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
                                        <a href="${pageContext.request.contextPath}/books?action=add" class="btn btn-primary btn-block w-100">
                                            <i class="fas fa-plus"></i> Add New Book
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/issues?action=issue" class="btn btn-success btn-block w-100"></a>
                                            <i class="fas fa-hand-holding"></i> Issue Book
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/issues?action=return" class="btn btn-info btn-block w-100">
                                            <i class="fas fa-undo"></i> Return Book
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="${pageContext.request.contextPath}/issues?action=overdue" class="btn btn-warning btn-block w-100"></a>
                                            <i class="fas fa-exclamation-triangle"></i> View Overdue
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Recent Book Issues</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Book ID</th>
                                                <th>User ID</th>
                                                <th>Issue Date</th>
                                                <th>Due Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="issue" items="${recentIssues}">
                                                <tr>
                                                    <td>${issue.bookId}</td>
                                                    <td>${issue.userId}</td>
                                                    <td>${issue.issueDate}</td>
                                                    <td>${issue.dueDate}</td>
                                                    <td>
                                                        <span class="badge bg-${issue.status == 'ISSUED' ? 'primary' : 
                                                                              issue.status == 'RETURNED' ? 'success' : 'warning'}">
                                                            ${issue.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
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