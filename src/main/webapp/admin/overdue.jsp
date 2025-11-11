<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Overdue Books</title>
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
                    <h1 class="h2"><i class="fas fa-exclamation-triangle text-warning"></i> Overdue Books</h1>
                    <a href="../issues?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
                <div class="card">
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead class="table-dark"><tr><th>Book</th><th>Student</th><th>Issue Date</th><th>Due Date</th><th>Days Overdue</th></tr></thead>
                            <tbody>
                                <c:forEach var="issueDetail" items="${issues}">
                                    <c:set var="issue" value="${issueDetail.issue}"/>
                                    <c:set var="book" value="${issueDetail.book}"/>
                                    <c:set var="user" value="${issueDetail.user}"/>
                                    <tr class="table-warning">
                                        <td><strong>${book.title}</strong></td>
                                        <td>${user.fullName}<br><small>${user.email}</small></td>
                                        <td><fmt:formatDate value="${issue.issueDate}" pattern="MMM dd, yyyy"/></td>
                                        <td><fmt:formatDate value="${issue.dueDate}" pattern="MMM dd, yyyy"/></td>
                                        <td><span class="badge bg-danger">${issue.daysOverdue} days</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>