<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book - Library Management System</title>
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
                            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/books?action=list">
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
                    <h1 class="h2">Add New Book</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="../books?action=list" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Books
                        </a>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Add Book Form -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-plus"></i> Book Information</h5>
                            </div>
                            <div class="card-body">
                                <form action="../books" method="post">
                                    <input type="hidden" name="action" value="add">
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="isbn" class="form-label">ISBN *</label>
                                            <input type="text" class="form-control" id="isbn" name="isbn" 
                                                   required placeholder="Enter ISBN">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="category" class="form-label">Category *</label>
                                            <select class="form-select" id="category" name="category" required>
                                                <option value="">Select Category</option>
                                                <option value="Fiction">Fiction</option>
                                                <option value="Non-Fiction">Non-Fiction</option>
                                                <option value="Science">Science</option>
                                                <option value="Technology">Technology</option>
                                                <option value="History">History</option>
                                                <option value="Biography">Biography</option>
                                                <option value="Education">Education</option>
                                                <option value="Reference">Reference</option>
                                                <option value="Literature">Literature</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="title" class="form-label">Title *</label>
                                        <input type="text" class="form-control" id="title" name="title" 
                                               required placeholder="Enter book title">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="author" class="form-label">Author *</label>
                                        <input type="text" class="form-control" id="author" name="author" 
                                               required placeholder="Enter author name">
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="publisher" class="form-label">Publisher</label>
                                            <input type="text" class="form-control" id="publisher" name="publisher" 
                                                   placeholder="Enter publisher name">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="publishedDate" class="form-label">Published Date</label>
                                            <input type="date" class="form-control" id="publishedDate" name="publishedDate">
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="totalCopies" class="form-label">Total Copies *</label>
                                        <input type="number" class="form-control" id="totalCopies" name="totalCopies" 
                                               required min="1" value="1" placeholder="Enter number of copies">
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="4" placeholder="Enter book description (optional)"></textarea>
                                    </div>
                                    
                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                        <button type="reset" class="btn btn-outline-secondary me-md-2">
                                            <i class="fas fa-undo"></i> Reset
                                        </button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> Add Book
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="mb-0"><i class="fas fa-info-circle"></i> Guidelines</h6>
                            </div>
                            <div class="card-body">
                                <ul class="list-unstyled">
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i> 
                                        Ensure ISBN is unique and valid
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i> 
                                        Use proper title case for book titles
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i> 
                                        Include full author name
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i> 
                                        Select appropriate category
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i> 
                                        Enter accurate copy count
                                    </li>
                                </ul>
                                
                                <div class="alert alert-info mt-3">
                                    <small>
                                        <i class="fas fa-lightbulb"></i> 
                                        Fields marked with * are required
                                    </small>
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