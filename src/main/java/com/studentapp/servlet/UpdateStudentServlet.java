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

@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Student student = studentDAO.getStudentById(id);
            if (student == null) {
                req.setAttribute("errorMessage", "No student found with id " + id);
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("student", student);
            req.getRequestDispatcher("/WEB-INF/views/updateStudent.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid student id.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while loading student: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("studentId"));
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String course = req.getParameter("course");
            double marks = Double.parseDouble(req.getParameter("marks"));

            if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                req.setAttribute("errorMessage", "Name and email cannot be empty.");
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
                return;
            }

            Student s = new Student(id, name.trim(), email.trim(), phone, course, marks);
            studentDAO.updateStudent(s);
            resp.sendRedirect("viewStudents?msg=Student+updated+successfully");
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid id or marks value.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while updating student: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}