<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
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
                        <li class="nav-item"><a class="nav-link text-white active" href="${pageContext.request.contextPath}/users?action=list"><i class="fas fa-users"></i> Manage Users</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
                        <li class="nav-item mt-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Edit User</h1>
                    <a href="${pageContext.request.contextPath}/users?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
                <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/users" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${user.id}">
                            <div class="mb-3"><label>Username</label><input type="text" class="form-control" value="${user.username}" readonly></div>
                            <div class="mb-3"><label>Full Name *</label><input type="text" class="form-control" name="fullName" value="${user.fullName}" required></div>
                            <div class="mb-3"><label>Email *</label><input type="email" class="form-control" name="email" value="${user.email}" required></div>
                            <div class="row">
                                <div class="col-md-6 mb-3"><label>Phone</label><input type="text" class="form-control" name="phone" value="${user.phone}"></div>
                                <div class="col-md-6 mb-3"><label>Role *</label>
                                    <select class="form-select" name="role" required>
                                        <option value="STUDENT" ${user.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                        <option value="LIBRARIAN" ${user.role == 'LIBRARIAN' ? 'selected' : ''}>Librarian</option>
                                        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3"><label>Address</label><textarea class="form-control" name="address" rows="2">${user.address}</textarea></div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" name="active" value="true" ${user.active ? 'checked' : ''}>
                                <label class="form-check-label">Active Account</label>
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update User</button>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>