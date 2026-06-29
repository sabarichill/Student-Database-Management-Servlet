package com.studentapp.servlet;

import com.studentapp.dao.StudentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deleteStudent")
public class DeleteStudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            studentDAO.deleteStudent(id);
            resp.sendRedirect("viewStudents?msg=Student+deleted+successfully");
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid student id.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while deleting student: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}