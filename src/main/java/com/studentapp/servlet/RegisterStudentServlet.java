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
import java.util.regex.Pattern;

@WebServlet("/addStudent")
public class RegisterStudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{7,15}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/addStudent.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = trim(req.getParameter("name"));
        String email = trim(req.getParameter("email"));
        String phone = trim(req.getParameter("phone"));
        String course = trim(req.getParameter("course"));
        String marksRaw = trim(req.getParameter("marks"));

        String error = validate(name, email, phone, course, marksRaw);
        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("name", name);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("course", course);
            req.setAttribute("marks", marksRaw);
            req.getRequestDispatcher("/WEB-INF/views/addStudent.jsp").forward(req, resp);
            return;
        }

        try {
            Student s = new Student();
            s.setName(name);
            s.setEmail(email);
            s.setPhone(phone);
            s.setCourse(course);
            s.setMarks(Double.parseDouble(marksRaw));
            studentDAO.addStudent(s);
            resp.sendRedirect("viewStudents?msg=Student+added+successfully");
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error while adding student: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    private String validate(String name, String email, String phone, String course, String marksRaw) {
        if (name.isEmpty() || email.isEmpty() || phone.isEmpty() || course.isEmpty() || marksRaw.isEmpty()) {
            return "All fields are required.";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Please enter a valid email address.";
        }
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            return "Phone number must be 7-15 digits.";
        }
        try {
            double marks = Double.parseDouble(marksRaw);
            if (marks < 0 || marks > 100) {
                return "Marks must be between 0 and 100.";
            }
        } catch (NumberFormatException e) {
            return "Marks must be a valid number.";
        }
        return null;
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }
}