package com.library.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/student/*", "/books", "/issues", "/users", "/reports"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (!isLoggedIn) {
            // Redirect to login page
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }
        
        // Check role-based access
        String role = (String) session.getAttribute("role");
        
        // Admin/Librarian trying to access student pages
        if (requestURI.contains("/student/") && 
            (role.equals("ADMIN") || role.equals("LIBRARIAN"))) {
            httpResponse.sendRedirect(contextPath + "/admin/dashboard.jsp");
            return;
        }
        
        // Student trying to access admin pages or admin servlets
        if (role.equals("STUDENT")) {
            if (requestURI.contains("/admin/") || 
                requestURI.contains("/issues") || 
                requestURI.contains("/users") || 
                requestURI.contains("/reports")) {
                httpResponse.sendRedirect(contextPath + "/student/dashboard.jsp");
                return;
            }
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}