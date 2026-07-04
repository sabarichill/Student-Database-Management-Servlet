<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error — Student Records Portal</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="error-page">
  <div class="error-card">

    <div class="error-card-top">
      <p class="error-code">500</p>
      <h1 class="error-title">Something went wrong</h1>
    </div>

    <div class="error-card-body">
      <p style="font-size:14px;color:var(--text-muted);margin-bottom:16px;">
        The portal encountered an unexpected error. The details are shown below.
      </p>

      <div class="error-msg">
        <%
          String msg = (String) request.getAttribute("errorMessage");
          if (msg == null && exception != null) msg = exception.getMessage();
          if (msg == null) msg = "An unexpected error occurred. Please try again.";
          out.print(msg);
        %>
      </div>

      <div class="error-actions">
        <a href="dashboard.jsp" class="btn btn-primary">← Back to Dashboard</a>
        <a href="login.jsp" class="btn btn-ghost">Go to Login</a>
      </div>
    </div>

  </div>
</div>
</body>
</html>
