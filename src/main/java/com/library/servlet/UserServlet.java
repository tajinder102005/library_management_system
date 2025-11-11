package com.library.servlet;

import com.library.dao.UserDAO;
import com.library.model.User;
import org.bson.types.ObjectId;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addUser(request, response);
        } else if ("update".equals(action)) {
            updateUser(request, response);
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/add-user.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("id");
        if (userId != null) {
            User user = userDAO.getUserById(new ObjectId(userId));
            request.setAttribute("user", user);
        }
        request.getRequestDispatcher("/admin/edit-user.jsp").forward(request, response);
    }
    
    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String roleStr = request.getParameter("role");
            
            User.UserRole role = User.UserRole.valueOf(roleStr);
            
            User user = new User(username, password, email, fullName, role);
            user.setPhone(phone);
            user.setAddress(address);
            
            if (userDAO.addUser(user)) {
                request.setAttribute("success", "User added successfully");
            } else {
                request.setAttribute("error", "Failed to add user");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error adding user: " + e.getMessage());
        }
        
        showAddForm(request, response);
    }
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userId = request.getParameter("id");
            User user = userDAO.getUserById(new ObjectId(userId));
            
            if (user != null) {
                user.setEmail(request.getParameter("email"));
                user.setFullName(request.getParameter("fullName"));
                user.setPhone(request.getParameter("phone"));
                user.setAddress(request.getParameter("address"));
                user.setRole(User.UserRole.valueOf(request.getParameter("role")));
                user.setActive(Boolean.parseBoolean(request.getParameter("active")));
                
                if (userDAO.updateUser(user)) {
                    request.setAttribute("success", "User updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update user");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating user: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/users?action=list");
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("id");
        if (userId != null) {
            if (userDAO.deleteUser(new ObjectId(userId))) {
                request.setAttribute("success", "User deleted successfully");
            } else {
                request.setAttribute("error", "Failed to delete user");
            }
        }
        response.sendRedirect(request.getContextPath() + "/users?action=list");
    }
}