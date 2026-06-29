<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Students - Student Management System</title>
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
    <h1>Search Students</h1>

    <form action="searchStudent" method="get">
        <div class="field">
            <label for="keyword">Name or Course</label>
            <input type="text" id="keyword" name="keyword" value="${keyword}" placeholder="e.g. Sneha or Electronics">
        </div>
        <button type="submit">Search</button>
    </form>

    <c:if test="${not empty keyword}">
        <h2>Results for "${keyword}"</h2>
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Course</th><th>Marks</th><th>Actions</th>
            </tr>
            <c:choose>
                <c:when test="${empty students}">
                    <tr><td colspan="7">No matching students found.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="s" items="${students}">
                        <tr>
                            <td>${s.studentId}</td>
                            <td>${s.name}</td>
                            <td>${s.email}</td>
                            <td>${s.phone}</td>
                            <td>${s.course}</td>
                            <td>${s.marks}</td>
                            <td class="actions">
                                <a href="updateStudent?id=${s.studentId}">Edit</a>
                                <a href="deleteStudent?id=${s.studentId}"
                                   onclick="return confirm('Delete this student record?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </c:if>
</div>
</body>
</html>