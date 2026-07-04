<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>All Students — Student Records Portal</title>
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
    <span class="breadcrumb-current">All Students</span>
  </div>

  <div class="page-header">
    <div>
      <h1 class="page-title">Student Register</h1>
      <p class="page-title-sub">Page ${currentPage} of ${totalPages} · showing up to 5 records per page</p>
    </div>
    <a href="addStudent" class="btn btn-primary">+ Add Student</a>
  </div>

  <c:if test="${not empty param.msg}">
    <div class="alert alert-success" style="margin-bottom:24px;">
      <span class="alert-icon">✓</span>
      <div class="alert-body">${param.msg}</div>
    </div>
  </c:if>

  <div class="card">
    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Student Name</th>
            <th>Email Address</th>
            <th>Phone</th>
            <th>Programme</th>
            <th>Marks</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty students}">
              <tr>
                <td colspan="7">
                  <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <div class="empty-state-title">No students found</div>
                    <p class="empty-state-desc">Add your first student to get started.</p>
                    <a href="addStudent" class="btn btn-primary btn-sm">Add First Student</a>
                  </div>
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="s" items="${students}">
                <tr>
                  <td class="td-id">#${s.studentId}</td>
                  <td><strong>${s.name}</strong></td>
                  <td>${s.email}</td>
                  <td>${s.phone}</td>
                  <td><span class="badge badge-course">${s.course}</span></td>
                  <td class="td-marks
                    <c:choose>
                      <c:when test="${s.marks >= 75}"> marks-high</c:when>
                      <c:when test="${s.marks >= 50}"> marks-mid</c:when>
                      <c:otherwise> marks-low</c:otherwise>
                    </c:choose>">${s.marks}%</td>
                  <td>
                    <div class="actions">
                      <a href="updateStudent?id=${s.studentId}" class="action-btn action-btn-edit">✏ Edit</a>
                      <a href="deleteStudent?id=${s.studentId}"
                         class="action-btn action-btn-delete"
                         onclick="return confirm('Delete record for ${s.name}? This cannot be undone.');">✕ Delete</a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>

    <c:if test="${totalPages > 1}">
      <div class="pagination">
        <span class="pagination-info">Page ${currentPage} of ${totalPages}</span>
        <div class="pagination-links">
          <c:if test="${currentPage > 1}">
            <a href="viewStudents?page=${currentPage - 1}">‹</a>
          </c:if>
          <c:forEach var="p" begin="1" end="${totalPages}">
            <a href="viewStudents?page=${p}" class="${p == currentPage ? 'active' : ''}">${p}</a>
          </c:forEach>
          <c:if test="${currentPage < totalPages}">
            <a href="viewStudents?page=${currentPage + 1}">›</a>
          </c:if>
        </div>
      </div>
    </c:if>
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
