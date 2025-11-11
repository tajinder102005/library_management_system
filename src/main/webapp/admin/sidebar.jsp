<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
    <div class="position-sticky pt-3">
        <div class="text-center text-white mb-4">
            <h4><i class="fas fa-book"></i> Library Admin</h4>
            <p>Welcome, ${sessionScope.username}</p>
        </div>
        
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-white ${param.page == 'dashboard' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.page == 'books' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/books?action=list">
                    <i class="fas fa-book"></i> Manage Books
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.page == 'issues' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/issues?action=list">
                    <i class="fas fa-exchange-alt"></i> Book Issues
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.page == 'users' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/users?action=list">
                    <i class="fas fa-users"></i> Manage Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${param.page == 'reports' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/reports">
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
<style>
    .sidebar {
        min-height: 100vh;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .sidebar .nav-link.active {
        background-color: rgba(255, 255, 255, 0.2);
        border-radius: 5px;
    }
</style>