<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentapp.dao.StudentDAO" %>
<%
    StudentDAO dao = new StudentDAO();
    int total = 0;
    try { total = dao.getTotalStudentCount(); } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard — Student Records Portal</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%-- NAVBAR --%>
<nav class="navbar" id="mainNav">
  <div class="navbar-top-row">
    <a href="dashboard.jsp" class="navbar-brand">
      <div class="navbar-brand-icon">GU</div>
      <div class="navbar-brand-name">
        Greenfield University
        <span class="navbar-brand-sub">Student Records Portal</span>
      </div>
    </a>
    <button class="navbar-toggle" onclick="toggleNav()" aria-label="Menu">☰</button>
  </div>
  <div class="navbar-links" id="navLinks">
    <a href="dashboard.jsp" class="active">Dashboard</a>
    <a href="viewStudents">All Students</a>
    <a href="addStudent">Add Student</a>
    <a href="searchStudent">Search</a>
  </div>
  <div class="navbar-user" id="navUser">
    <span class="navbar-user-name">Signed in as <strong>${sessionScope.loggedInUser}</strong></span>
    <a href="logout" class="navbar-logout">Sign Out</a>
  </div>
</nav>

<div class="page">

  <div class="breadcrumb">
    <span class="breadcrumb-current">Dashboard</span>
  </div>

  <div class="page-header">
    <div>
      <h1 class="page-title">Welcome back, ${sessionScope.loggedInUser}</h1>
      <p class="page-title-sub">Greenfield University · Student Records Management System</p>
    </div>
    <a href="addStudent" class="btn btn-primary">+ Add Student</a>
  </div>

  <%-- STAT CARDS --%>
  <div class="stat-grid">
    <div class="stat-card">
      <div class="stat-value"><%= total %></div>
      <div class="stat-label">Total Students</div>
    </div>
    <div class="stat-card">
      <div class="stat-value">1</div>
      <div class="stat-label">Admin Users</div>
    </div>
    <div class="stat-card">
      <div class="stat-value">Active</div>
      <div class="stat-label">Portal Status</div>
    </div>
    <div class="stat-card">
      <div class="stat-value">2025</div>
      <div class="stat-label">Academic Year</div>
    </div>
  </div>

  <%-- QUICK ACTIONS --%>
  <div class="card" style="margin-bottom: 24px;">
    <div class="card-header">
      <h2 class="card-title">Quick Actions</h2>
    </div>
    <div class="action-grid">
      <a href="viewStudents" class="action-card">
        <div class="action-card-icon">📋</div>
        <div>
          <div class="action-card-title">View All Students</div>
          <p class="action-card-desc">Browse, sort and manage the full student register.</p>
        </div>
      </a>
      <a href="addStudent" class="action-card">
        <div class="action-card-icon rust">➕</div>
        <div>
          <div class="action-card-title">Add New Student</div>
          <p class="action-card-desc">Register a new student record in the system.</p>
        </div>
      </a>
      <a href="searchStudent" class="action-card">
        <div class="action-card-icon">🔍</div>
        <div>
          <div class="action-card-title">Search Students</div>
          <p class="action-card-desc">Find students by name or enrolled course.</p>
        </div>
      </a>
    </div>
  </div>

</div>

<script>
function toggleNav() {
  document.getElementById('navLinks').classList.toggle('open');
  document.getElementById('navUser').classList.toggle('open');
}
</script>
</body>
</html>
