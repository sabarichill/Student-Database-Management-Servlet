<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-box">
    <h1>Create Account</h1>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
            <% if (request.getAttribute("showLoginLink") != null) { %>
                &nbsp;<a href="login">Login here</a>
            <% } %>
        </div>
    <% } %>

    <form action="signup" method="post">
        <div class="field">
            <label for="userId">Choose a User ID</label>
            <input type="text" id="userId" name="userId" value="${userId}" required autofocus>
        </div>
        <div class="field">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="field">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <button type="submit">Sign Up</button>
    </form>

    <p class="helper-text">
        Already have an account? <a href="login">Login</a>
    </p>
</div>
</body>
</html>