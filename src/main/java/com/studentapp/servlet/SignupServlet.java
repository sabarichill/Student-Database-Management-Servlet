package com.studentapp.servlet;

import com.studentapp.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (userId == null || userId.trim().isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "User ID and password are required.");
            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
            return;
        }
        userId = userId.trim();

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.setAttribute("userId", userId);
            req.getRequestDispatcher("/signup.jsp").forward(req, resp);
            return;
        }

        try {
            if (userDAO.userExists(userId)) {
                req.setAttribute("error", "This user ID already exists. Please sign in instead.");
                req.setAttribute("showLoginLink", true);
                req.getRequestDispatcher("/signup.jsp").forward(req, resp);
                return;
            }

            userDAO.createUser(userId, password);
            req.setAttribute("success", "Account created! You can now log in.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error during signup: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}