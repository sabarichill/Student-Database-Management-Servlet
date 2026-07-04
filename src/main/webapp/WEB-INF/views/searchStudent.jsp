<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Students — Student Records Portal</title>
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
    <a href="viewStudents">All Students</a>
    <a href="addStudent">Add Student</a>
    <a href="searchStudent" class="active">Search</a>
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
    <span class="breadcrumb-current">Search Students</span>
  </div>

  <div class="page-header">
    <div>
      <h1 class="page-title">Search Students</h1>
      <p class="page-title-sub">Find students by name or enrolled programme</p>
    </div>
  </div>

  <form action="searchStudent" method="get">
    <div class="search-bar">
      <input type="text" name="keyword" value="${keyword}"
             placeholder="Search by student name or course…" autofocus>
      <button type="submit" class="btn btn-primary">Search</button>
      <c:if test="${not empty keyword}">
        <a href="searchStudent" class="btn btn-ghost">Clear</a>
      </c:if>
    </div>
  </form>

  <c:if test="${not empty keyword}">
    <div class="card">

      <div class="card-header">
        <h2 class="card-title">
          Results for "<c:out value="${keyword}"/>"
        </h2>
        <span style="font-size:13px;color:var(--text-muted);">
          <c:choose>
            <c:when test="${empty students}">0 records found</c:when>
            <c:otherwise>${students.size()} record(s) found</c:otherwise>
          </c:choose>
        </span>
      </div>

      <c:choose>
        <c:when test="${empty students}">
          <div class="empty-state">
            <div class="empty-state-icon">🔍</div>
            <div class="empty-state-title">No students matched</div>
            <p class="empty-state-desc">Try a different name or course keyword.</p>
          </div>
        </c:when>
        <c:otherwise>
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
                           onclick="return confirm('Delete record for ${s.name}?');">✕ Delete</a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </c:if>

</div>

<script>
function toggleNav() {
  document.getElementById('navLinks').classList.toggle('open');
  document.getElementById('navUser').classList.toggle('open');
}
</script>
</body>
</html>
