<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - Library Management System</title>
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
                    <h1 class="h2">Edit Book</h1>
                    <a href="${pageContext.request.contextPath}/books?action=list" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                </div>
                <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/books" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="id" value="${book.id}">
                            <div class="row">
                                <div class="col-md-6 mb-3"><label>ISBN *</label><input type="text" class="form-control" name="isbn" value="${book.isbn}" readonly></div>
                                <div class="col-md-6 mb-3"><label>Category *</label>
                                    <select class="form-select" name="category" required>
                                        <option value="Fiction" ${book.category == 'Fiction' ? 'selected' : ''}>Fiction</option>
                                        <option value="Non-Fiction" ${book.category == 'Non-Fiction' ? 'selected' : ''}>Non-Fiction</option>
                                        <option value="Science" ${book.category == 'Science' ? 'selected' : ''}>Science</option>
                                        <option value="Technology" ${book.category == 'Technology' ? 'selected' : ''}>Technology</option>
                                        <option value="History" ${book.category == 'History' ? 'selected' : ''}>History</option>
                                        <option value="Biography" ${book.category == 'Biography' ? 'selected' : ''}>Biography</option>
                                        <option value="Education" ${book.category == 'Education' ? 'selected' : ''}>Education</option>
                                        <option value="Reference" ${book.category == 'Reference' ? 'selected' : ''}>Reference</option>
                                        <option value="Literature" ${book.category == 'Literature' ? 'selected' : ''}>Literature</option>
                                        <option value="Other" ${book.category == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3"><label>Title *</label><input type="text" class="form-control" name="title" value="${book.title}" required></div>
                            <div class="mb-3"><label>Author *</label><input type="text" class="form-control" name="author" value="${book.author}" required></div>
                            <div class="row">
                                <div class="col-md-6 mb-3"><label>Publisher</label><input type="text" class="form-control" name="publisher" value="${book.publisher}"></div>
                                <div class="col-md-6 mb-3"><label>Published Date</label><input type="date" class="form-control" name="publishedDate" value="<fmt:formatDate value='${book.publishedDate}' pattern='yyyy-MM-dd'/>"></div>
                            </div>
                            <div class="mb-3"><label>Total Copies *</label><input type="number" class="form-control" name="totalCopies" value="${book.totalCopies}" required min="1"></div>
                            <div class="mb-3"><label>Description</label><textarea class="form-control" name="description" rows="4">${book.description}</textarea></div>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Book</button>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>