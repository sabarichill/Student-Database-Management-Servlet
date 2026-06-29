package com.studentapp.servlet;

import com.studentapp.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private static final int COOKIE_MAX_AGE = 7 * 24 * 60 * 60;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String password = req.getParameter("password");

        if (userId == null || userId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "User ID and password are required.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        userId = userId.trim();

        try {
            // Case 1: user id doesn't exist at all
            if (!userDAO.userExists(userId)) {
                req.setAttribute("error", "This user ID doesn't exist. Please sign up to create an account.");
                req.setAttribute("showSignupLink", true);
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            // Case 2: user id exists, password wrong
            if (!userDAO.isPasswordCorrect(userId, password)) {
                req.setAttribute("error", "Your password is wrong. Try another password.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            // Case 3: correct login -> session + cookie -> dashboard
            HttpSession session = req.getSession();
            session.setAttribute("loggedInUser", userId);
            session.setMaxInactiveInterval(30 * 60);

            Cookie loginCookie = new Cookie("loggedInUser", userId);
            loginCookie.setMaxAge(COOKIE_MAX_AGE);
            loginCookie.setPath(req.getContextPath() + "/");
            loginCookie.setHttpOnly(true);
            resp.addCookie(loginCookie);

            resp.sendRedirect("dashboard.jsp");

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error during login: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}