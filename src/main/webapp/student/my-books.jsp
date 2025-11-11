<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.library.dao.*" %>
<%@ page import="com.library.model.*" %>
<%@ page import="org.bson.types.ObjectId" %>
<%@ page import="java.util.*" %>

<%
    String userIdStr = (String) session.getAttribute("userId");
    if (userIdStr != null) {
        BookIssueDAO issueDAO = new BookIssueDAO();
        BookDAO bookDAO = new BookDAO();
        
        ObjectId userId = new ObjectId(userIdStr);
        List<BookIssue> userIssues = issueDAO.getActiveIssuesByUser(userId);
        
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
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Books</title>
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
                        <li class="nav-item"><a class="nav-link text-white active" href="${pageContext.request.contextPath}/student/my-books.jsp"><i class="fas fa-book-reader"></i> My Books</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/student/history.jsp"><i class="fas fa-history"></i> Borrowing History</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/student/profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
                        <li class="nav-item mt-3"><a class="nav-link text-white" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="pt-3 pb-2 mb-3 border-bottom"><h1 class="h2">My Currently Issued Books</h1></div>
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty issuedBooks}">
                                <table class="table table-striped">
                                    <thead><tr><th>Book</th><th>Issue Date</th><th>Due Date</th><th>Status</th></tr></thead>
                                    <tbody>
                                        <c:forEach var="bookIssue" items="${issuedBooks}">
                                            <c:set var="issue" value="${bookIssue.issue}"/>
                                            <c:set var="book" value="${bookIssue.book}"/>
                                            <tr>
                                                <td><strong>${book.title}</strong><br><small>${book.author}</small></td>
                                                <td><fmt:formatDate value="${issue.issueDate}" pattern="MMM dd, yyyy"/></td>
                                                <td><fmt:formatDate value="${issue.dueDate}" pattern="MMM dd, yyyy"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${issue.overdue}">
                                                            <span class="badge bg-danger">Overdue</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success">Active</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-book fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">You don't have any books currently issued.</p>
                                    <a href="${pageContext.request.contextPath}/books?action=search" class="btn btn-primary">Browse Books</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>