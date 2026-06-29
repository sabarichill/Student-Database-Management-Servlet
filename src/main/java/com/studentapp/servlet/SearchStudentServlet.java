package com.studentapp.servlet;

import com.studentapp.dao.StudentDAO;
import com.studentapp.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/searchStudent")
public class SearchStudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            req.getRequestDispatcher("/WEB-INF/views/searchStudent.jsp").forward(req, resp);
            return;
        }

        try {
            List<Student> results = studentDAO.searchStudents(keyword.trim());
            req.setAttribute("students", results);
            req.setAttribute("keyword", keyword.trim());
            req.getRequestDispatcher("/WEB-INF/views/searchStudent.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while searching: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}