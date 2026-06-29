<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container" style="max-width:600px;">
    <h1>Something went wrong</h1>
    <div class="alert alert-error">
        <%
            String msg = (String) request.getAttribute("errorMessage");
            if (msg == null && exception != null) {
                msg = exception.getMessage();
            }
            if (msg == null) {
                msg = "An unexpected error occurred.";
            }
        %>
        <%= msg %>
    </div>
    <a href="dashboard.jsp" class="btn">Back to Dashboard</a>
    <a href="login.jsp" class="btn btn-secondary">Back to Login</a>
</div>
</body>
</html>