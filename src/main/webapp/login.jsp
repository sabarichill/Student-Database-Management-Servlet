<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-box">
    <h1>Login</h1>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
            <% if (request.getAttribute("showSignupLink") != null) { %>
                &nbsp;<a href="signup">Sign up here</a>
            <% } %>
        </div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-error"><%= request.getParameter("error") %></div>
    <% } %>
    <% if (request.getParameter("msg") != null) { %>
        <div class="alert alert-success"><%= request.getParameter("msg") %></div>
    <% } %>

    <form action="login" method="post">
        <div class="field">
            <label for="userId">User ID</label>
            <input type="text" id="userId" name="userId" required autofocus>
        </div>
        <div class="field">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
    </form>

    <p class="helper-text">
        Don't have an account? <a href="signup">Sign up</a>
    </p>
</div>
</body>
</html>