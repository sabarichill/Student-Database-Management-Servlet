<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign In — Student Records Portal</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="auth-page">

  <div class="auth-header">
    <div class="auth-logo">GU</div>
    <h1 class="auth-title">Greenfield University</h1>
    <p class="auth-subtitle">Student Records Portal</p>
  </div>

  <div class="auth-card">

    <div class="auth-card-header">
      <div>
        <h1>Sign In</h1>
        <p>Access your portal account</p>
      </div>
    </div>

    <div class="auth-card-body">

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
          <span class="alert-icon">⚠</span>
          <div class="alert-body">
            <%= request.getAttribute("error") %>
            <% if (request.getAttribute("showSignupLink") != null) { %>
              <a href="signup">Create account →</a>
            <% } %>
          </div>
        </div>
      <% } %>

      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
          <span class="alert-icon">✓</span>
          <div class="alert-body"><%= request.getAttribute("success") %></div>
        </div>
      <% } %>

      <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-error">
          <span class="alert-icon">⚠</span>
          <div class="alert-body"><%= request.getParameter("error") %></div>
        </div>
      <% } %>

      <% if (request.getParameter("msg") != null) { %>
        <div class="alert alert-success">
          <span class="alert-icon">✓</span>
          <div class="alert-body"><%= request.getParameter("msg") %></div>
        </div>
      <% } %>

      <form action="login" method="post">
        <div class="field">
          <label for="userId" class="field-required">User ID</label>
          <input type="text" id="userId" name="userId" placeholder="Enter your user ID" required autofocus autocomplete="username">
        </div>
        <div class="field">
          <label for="password" class="field-required">Password</label>
          <input type="password" id="password" name="password" placeholder="Enter your password" required autocomplete="current-password">
        </div>
        <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">Sign In to Portal</button>
      </form>

    </div>

    <div class="auth-card-footer">
      <span>New to the portal?</span>
      <a href="signup">Create an account</a>
    </div>

  </div>

</div>
</body>
</html>
