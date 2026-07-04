<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Student — Student Records Portal</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
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
    <a href="dashboard.jsp">Dashboard</a>
    <a href="viewStudents" class="active">All Students</a>
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
    <a href="dashboard.jsp">Dashboard</a>
    <span class="breadcrumb-sep">›</span>
    <a href="viewStudents">All Students</a>
    <span class="breadcrumb-sep">›</span>
    <span class="breadcrumb-current">Edit Student #${student.studentId}</span>
  </div>

  <div class="page-header">
    <div>
      <h1 class="page-title">Edit Student Record</h1>
      <p class="page-title-sub">ID: <span style="font-family:var(--mono);color:var(--text-muted);">#${student.studentId}</span> · ${student.name}</p>
    </div>
    <a href="viewStudents" class="btn btn-ghost">← Back to Students</a>
  </div>

  <div class="form-section">
    <div class="form-section-header">
      <h2>Update Student Information</h2>
      <p>Edit the details below and save to update the record</p>
    </div>

    <form action="updateStudent" method="post">
      <input type="hidden" name="studentId" value="${student.studentId}">
      <div class="form-body">
        <div class="form-grid">
          <div class="field">
            <label class="field-required">Full Name</label>
            <input type="text" name="name" value="${student.name}" required>
          </div>
          <div class="field">
            <label class="field-required">Email Address</label>
            <input type="email" name="email" value="${student.email}" required>
          </div>
          <div class="field">
            <label class="field-required">Phone Number</label>
            <input type="text" name="phone" value="${student.phone}" required>
          </div>
          <div class="field">
            <label class="field-required">Course / Programme</label>
            <input type="text" name="course" value="${student.course}" required>
          </div>
          <div class="field">
            <label class="field-required">Marks (0 – 100)</label>
            <input type="number" name="marks" value="${student.marks}" step="0.01" min="0" max="100" required>
          </div>
        </div>
      </div>
      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Update Record</button>
        <a href="viewStudents" class="btn btn-ghost">Cancel</a>
      </div>
    </form>
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
