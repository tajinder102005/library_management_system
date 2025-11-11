<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.library.dao.*" %>
<%@ page import="com.library.model.*" %>
<%@ page import="org.bson.types.ObjectId" %>

<%
    String userIdStr = (String) session.getAttribute("userId");
    if (userIdStr != null) {
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(new ObjectId(userIdStr));
        request.setAttribute("userProfile", user);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>.sidebar{min-height:100vh;background:linear-gradient(135deg,#28a745 0%,#20c997 100%)}</style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4"><h4><i class="fas fa-user-graduate"></i> Student Portal</h4><p>Welcome, ${sessionScope.username}</p></div>
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/student/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/books?action=search"><i class="fas fa-search"></i> Search Books</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/student/my-books.jsp"><i class="fas fa-book-reader"></i> My Books</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/student/history.jsp"><i class="fas fa-history"></i> Borrowing History</a></li>
                        <li class="nav-item"><a class="nav-link text-white active" href="${pageContext.request.contextPath}/student/profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                        <li class="nav-item mt-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="pt-3 pb-2 mb-3 border-bottom"><h1 class="h2">My Profile</h1></div>
                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header"><h5>Profile Information</h5></div>
                            <div class="card-body">
                                <table class="table">
                                    <tr><th width="30%">Username:</th><td>${userProfile.username}</td></tr>
                                    <tr><th>Full Name:</th><td>${userProfile.fullName}</td></tr>
                                    <tr><th>Email:</th><td>${userProfile.email}</td></tr>
                                    <tr><th>Phone:</th><td>${userProfile.phone}</td></tr>
                                    <tr><th>Address:</th><td>${userProfile.address}</td></tr>
                                    <tr><th>Role:</th><td><span class="badge bg-info">${userProfile.role}</span></td></tr>
                                    <tr><th>Status:</th><td><span class="badge bg-${userProfile.active ? 'success' : 'danger'}">${userProfile.active ? 'Active' : 'Inactive'}</span></td></tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header"><h5>Account Info</h5></div>
                            <div class="card-body">
                                <p><i class="fas fa-user-circle fa-3x text-primary"></i></p>
                                <p><strong>Member Since:</strong><br><small class="text-muted">Account created</small></p>
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