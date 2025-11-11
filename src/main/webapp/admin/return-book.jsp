<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Return Book - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>.sidebar{min-height:100vh;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%)}</style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4">
                        <h4><i class="fas fa-book"></i> Library Admin</h4>
                        <p>Welcome, ${sessionScope.username}</p>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/books?action=list"><i class="fas fa-book"></i> Manage Books</a></li>
                        <li class="nav-item"><a class="nav-link text-white active" href="${pageContext.request.contextPath}/issues?action=list"><i class="fas fa-exchange-alt"></i> Book Issues</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/users?action=list"><i class="fas fa-users"></i> Manage Users</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
                        <li class="nav-item mt-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Return Book</h1>
                    <a href="../issues?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show"><i class="fas fa-check-circle"></i> ${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show"><i class="fas fa-exclamation-circle"></i> ${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
                </c:if>
                <div class="card">
                    <div class="card-header"><h5 class="mb-0">Active Book Issues</h5></div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead><tr><th>Book</th><th>Student</th><th>Issue Date</th><th>Due Date</th><th>Action</th></tr></thead>
                                <tbody>
                                    <c:forEach var="issueDetail" items="${issues}">
                                        <c:set var="issue" value="${issueDetail.issue}"/>
                                        <c:set var="book" value="${issueDetail.book}"/>
                                        <c:set var="user" value="${issueDetail.user}"/>
                                        <tr>
                                            <td><strong>${book.title}</strong><br><small>${book.author}</small></td>
                                            <td>${user.fullName}</td>
                                            <td><fmt:formatDate value="${issue.issueDate}" pattern="MMM dd, yyyy"/></td>
                                            <td><fmt:formatDate value="${issue.dueDate}" pattern="MMM dd, yyyy"/></td>
                                            <td>
                                                <form action="../issues" method="post" style="display:inline">
                                                    <input type="hidden" name="action" value="return">
                                                    <input type="hidden" name="issueId" value="${issue.id}">
                                                    <input type="hidden" name="notes" value="Returned">
                                                    <button type="submit" class="btn btn-sm btn-success"><i class="fas fa-check"></i> Return</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
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