<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Student - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="viewStudents">View Students</a>
        <a href="addStudent">Add Student</a>
        <a href="searchStudent">Search</a>
    </div>
    <div>
        Welcome, <strong>${sessionScope.adminUser}</strong>
        &nbsp;|&nbsp; <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1>Add Student</h1>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="addStudent" method="post">
        <div class="field">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" value="${name}" required>
        </div>
        <div class="field">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${email}" required>
        </div>
        <div class="field">
            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" value="${phone}" required>
        </div>
        <div class="field">
            <label for="course">Course</label>
            <input type="text" id="course" name="course" value="${course}" required>
        </div>
        <div class="field">
            <label for="marks">Marks (0-100)</label>
            <input type="number" step="0.01" min="0" max="100" id="marks" name="marks" value="${marks}" required>
        </div>
        <button type="submit">Save Student</button>
        <a href="viewStudents" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>