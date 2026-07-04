<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account — Student Records Portal</title>
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
        <h1>Create Account</h1>
        <p>Register to access the portal</p>
      </div>
    </div>

    <div class="auth-card-body">

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
          <span class="alert-icon">⚠</span>
          <div class="alert-body">
            <%= request.getAttribute("error") %>
            <% if (request.getAttribute("showLoginLink") != null) { %>
              <a href="login">Sign in instead →</a>
            <% } %>
          </div>
        </div>
      <% } %>

      <form action="signup" method="post">
        <div class="field">
          <label for="userId" class="field-required">Choose a User ID</label>
          <input type="text" id="userId" name="userId" value="${userId}"
                 placeholder="e.g. john.doe2025" required autofocus autocomplete="username">
          <div class="field-hint">This will be your permanent login identifier.</div>
        </div>
        <div class="field">
          <label for="password" class="field-required">Password</label>
          <input type="password" id="password" name="password" placeholder="Choose a strong password" required autocomplete="new-password">
        </div>
        <div class="field">
          <label for="confirmPassword" class="field-required">Confirm Password</label>
          <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter your password" required autocomplete="new-password">
        </div>
        <button type="submit" class="btn btn-primary btn-full" style="margin-top:8px;">Create Account</button>
      </form>

    </div>

    <div class="auth-card-footer">
      <span>Already have an account?</span>
      <a href="login">Sign in</a>
    </div>

  </div>

</div>
</body>
</html>
