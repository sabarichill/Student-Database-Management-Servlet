<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Students - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="viewStudent">View Students</a>
        <a href="addStudent">Add Student</a>
        <a href="searchStudent">Search</a>
    </div>
    <div>
        Welcome, <strong>${sessionScope.adminUser}</strong>
        &nbsp;|&nbsp; <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1>All Students</h1>

    <c:if test="${not empty param.msg}">
        <div class="alert alert-success">${param.msg}</div>
    </c:if>

    <a href="addStudent" class="btn">+ Add New Student</a>

    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Course</th><th>Marks</th><th>Actions</th>
        </tr>
        <c:choose>
            <c:when test="${empty students}">
                <tr><td colspan="7">No students found.</td></tr>
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

    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:forEach var="p" begin="1" end="${totalPages}">
                <a href="viewStudents?page=${p}" class="${p == currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>
        </div>
    </c:if>
</div>
</body>
</html>