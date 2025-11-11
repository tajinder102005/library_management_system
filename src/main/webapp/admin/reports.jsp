<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
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
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/issues?action=list"><i class="fas fa-exchange-alt"></i> Book Issues</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/users?action=list"><i class="fas fa-users"></i> Manage Users</a></li>
                        <li class="nav-item"><a class="nav-link text-white active" href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
                        <li class="nav-item mt-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="pt-3 pb-2 mb-3 border-bottom"><h1 class="h2"><i class="fas fa-chart-bar"></i> Library Reports</h1></div>
                <div class="row mb-4">
                    <div class="col-md-3 mb-3"><div class="card text-white bg-primary"><div class="card-body"><h5>Total Books</h5><h2>${totalBooks}</h2></div></div></div>
                    <div class="col-md-3 mb-3"><div class="card text-white bg-success"><div class="card-body"><h5>Available</h5><h2>${availableBooks}</h2></div></div></div>
                    <div class="col-md-3 mb-3"><div class="card text-white bg-info"><div class="card-body"><h5>Issued</h5><h2>${issuedBooks}</h2></div></div></div>
                    <div class="col-md-3 mb-3"><div class="card text-white bg-warning"><div class="card-body"><h5>Overdue</h5><h2>${overdueCount}</h2></div></div></div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card"><div class="card-header"><h5>Books by Category</h5></div><div class="card-body"><table class="table"><thead><tr><th>Category</th><th>Count</th></tr></thead><tbody><c:forEach var="entry" items="${categoryCount}"><tr><td>${entry.key}</td><td><span class="badge bg-primary">${entry.value}</span></td></tr></c:forEach></tbody></table></div></div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card"><div class="card-header"><h5>Summary</h5></div><div class="card-body"><ul class="list-group list-group-flush"><li class="list-group-item d-flex justify-content-between">Total Students<span class="badge bg-primary">${totalStudents}</span></li><li class="list-group-item d-flex justify-content-between">Books Returned<span class="badge bg-success">${returnedBooks}</span></li><li class="list-group-item d-flex justify-content-between">Currently Issued<span class="badge bg-info">${issuedBooks}</span></li><li class="list-group-item d-flex justify-content-between">Overdue Books<span class="badge bg-danger">${overdueCount}</span></li></ul></div></div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>