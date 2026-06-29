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

@WebServlet("/viewStudents")
public class ViewStudentsServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int page = 1;
            String pageParam = req.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Math.max(1, Integer.parseInt(pageParam));
                } catch (NumberFormatException ignored) {
                    page = 1;
                }
            }

            int totalCount = studentDAO.getTotalStudentCount();
            int totalPages = Math.max(1, (int) Math.ceil(totalCount / (double) PAGE_SIZE));
            page = Math.min(page, totalPages);

            List<Student> students = studentDAO.getStudentsPaged(page, PAGE_SIZE);

            req.setAttribute("students", students);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/WEB-INF/views/viewStudents.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while fetching students: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}