<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Student Management System</title>
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
    <h1>Welcome to the Student Management System</h1>
    <p>Use the navigation bar above to manage student records.</p>

    <table>
        <tr>
            <td><a href="viewStudents" class="btn">View All Students</a></td>
            <td>Browse the full, paginated list of students.</td>
        </tr>
        <tr>
            <td><a href="addStudent" class="btn">Add Student</a></td>
            <td>Register a new student record.</td>
        </tr>
        <tr>
            <td><a href="searchStudent" class="btn">Search Students</a></td>
            <td>Find students by name or course.</td>
        </tr>
    </table>
</div>
</body>
</html>