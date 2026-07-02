# 🎓 Student Database Management System — Servlet Edition

A server-rendered (non-SPA) web application built with **Jakarta Servlets + JSP**, running on **Apache Tomcat**, with **MySQL** as the database — no framework like Spring involved. This is a "classic" Java EE-style CRUD app: every action is a servlet mapped to a URL, and pages are rendered with JSP + JSTL.

This is a separate, standalone project from the Spring Boot version (`Student-Database-Backend` + `Student-Database-Frontend`) — it demonstrates the same student-management functionality using raw Servlets/JDBC instead of Spring/React.

## How the Project Works

1. A user visits `login.jsp` or `signup.jsp` to authenticate.
2. **`LoginServlet`** validates credentials against the `UserDAO` (which queries MySQL via plain JDBC). On success, it sets an auth cookie; `CookieAuthFilter` protects the rest of the app by checking this cookie on every request.
3. **`SignupServlet`** registers new users via `UserDAO`.
4. Once logged in, the user lands on `dashboard.jsp`, from which they can:
   - **View** all students — `ViewStudentsServlet` fetches records via `StudentDAO` and forwards to `viewStudents.jsp`.
   - **Add** a student — `RegisterStudentServlet` inserts a new row via `StudentDAO`, form rendered by `addStudent.jsp`.
   - **Update** a student — `UpdateStudentServlet` + `updateStudent.jsp`.
   - **Delete** a student — `DeleteStudentServlet` removes a row by ID.
   - **Search** — `SearchStudentServlet` + `searchStudent.jsp` for keyword-based lookup.
5. **`LogoutServlet`** clears the auth cookie and redirects back to login.
6. **`DBConnection`** is a small JDBC utility class that opens a `Connection` to MySQL using credentials read from environment variables (`DB_URL`, `DB_USER`, `DB_PASSWORD`).
7. All DAO classes (`StudentDAO`, `UserDAO`, `AdminDAO`) contain raw SQL (`PreparedStatement`) — there is no ORM in this project, which is intentional (it demonstrates JDBC fundamentals).

## Tech Stack

|       Layer        |                    Technology                      |
|--------------------|----------------------------------------------------|
| Language           | Java 17                                            |
| Web Layer          | Jakarta Servlets 6.0, JSP, JSTL                    |
| Database Access    | Raw JDBC (`PreparedStatement`) — no ORM            |
| Database           | MySQL                                              |
| Application Server | Apache Tomcat 10.1                                 |
| Build Tool         | Maven (packaged as `.war`)                         |
| Containerization   | Docker (multi-stage: Maven build → Tomcat runtime) |

## Project Structure

```
src/main/java/com/studentapp/
├── servlet/
│   ├── LoginServlet.java
│   ├── LogoutServlet.java
│   ├── SignupServlet.java
│   ├── RegisterStudentServlet.java
│   ├── UpdateStudentServlet.java
│   ├── DeleteStudentServlet.java
│   ├── SearchStudentServlet.java
│   ├── ViewStudentsServlet.java
│   └── CookieAuthFilter.java       # Guards protected pages via auth cookie
├── dao/
│   ├── UserDAO.java                 # Login/signup DB queries
│   ├── AdminDAO.java
│   └── StudentDAO.java              # Student CRUD DB queries
├── model/
│   └── Student.java                 # Plain POJO
└── util/
    └── DBConnection.java             # JDBC connection factory

src/main/webapp/
├── login.jsp / signup.jsp / dashboard.jsp / error.jsp
├── css/style.css
└── WEB-INF/
    ├── web.xml
    └── views/
        ├── addStudent.jsp
        ├── updateStudent.jsp
        ├── searchStudent.jsp
        └── viewStudents.jsp
```

## Routes / Servlet Mappings

|       Purpose         |         Servlet          |              URL               |
|-----------------------|--------------------------|--------------------------------|
| Login (view + submit) | `LoginServlet`           | `/login`                       |
| Signup                | `SignupServlet`          | `/signup` (check annotation)   |
| Logout                | `LogoutServlet`          | `/logout`                      |
| View all students     | `ViewStudentsServlet`    | mapped in `web.xml`/annotation |
| Add student           | `RegisterStudentServlet` | mapped in `web.xml`/annotation |
| Update student        | `UpdateStudentServlet`   | mapped in `web.xml`/annotation |
| Delete student        | `DeleteStudentServlet`   | mapped in `web.xml`/annotation |
| Search students       | `SearchStudentServlet`   | mapped in `web.xml`/annotation |

> Check each servlet's `@WebServlet("/path")` annotation (or `web.xml`) for exact URLs — they're defined per-servlet rather than centrally.

## How to Build & Run

### Prerequisites
- Java 17 (JDK)
- Maven
- MySQL running with a database and the required tables for users/students
- Apache Tomcat 10.1 (a copy is vendored in this repo for local reference, but you don't need to use that exact copy — any Tomcat 10.1+/Jakarta EE 9+ compatible server works)

### 1. Configure the Database

Set the following environment variables before starting Tomcat:

```bash
export DB_URL="jdbc:mysql://localhost:3306/student_servlet_db"
export DB_USER="your_mysql_user"
export DB_PASSWORD="your_mysql_password"
```

Make sure your MySQL database has the expected `students` and `users` tables (create them manually — this project uses raw JDBC, so there's no auto-schema-generation like Hibernate's `ddl-auto`).

### 2. Build the WAR

```bash
git clone https://github.com/sabarichill/Student-Database-Management-Servlet.git
cd Student-Database-Management-Servlet

mvn clean package
```

This produces `target/StudentsDatabaseManagement.war`.

### 3. Deploy to Tomcat

Copy the WAR into Tomcat's `webapps/` folder (rename to `ROOT.war` to serve it at the root context, or keep its name to serve it at `/StudentsDatabaseManagement`):

```bash
cp target/StudentsDatabaseManagement.war $CATALINA_HOME/webapps/ROOT.war
$CATALINA_HOME/bin/startup.sh   # or startup.bat on Windows
```

Visit **`http://localhost:8080/`** and you should land on the login page.

### 4. Run with Docker (recommended — simplest path)

```bash
docker build -t student-servlet-app .
docker run -p 8080:8080 \
  -e DB_URL="jdbc:mysql://<host>:3306/student_servlet_db" \
  -e DB_USER="your_mysql_user" \
  -e DB_PASSWORD="your_mysql_password" \
  student-servlet-app
```

The Dockerfile builds the WAR with Maven, then copies it into an official `tomcat:10.1-jdk17` image as `ROOT.war`, so the app is served at `http://localhost:8080/`.

## Testing

This project doesn't currently include an automated test suite (no JUnit dependency in `pom.xml`). To test manually:
1. Start the app and MySQL.
2. Sign up a new user → confirm the row appears in the `users` table.
3. Log in → confirm the auth cookie is set and you're redirected to the dashboard.
4. Try accessing a protected page (e.g. `dashboard.jsp`) without logging in → `CookieAuthFilter` should redirect you to login.
5. Add / update / delete / search students → confirm the changes reflect correctly in MySQL and in the JSP views.

**To add automated tests going forward:**
- Add `junit-jupiter` and `mockito-core` as test dependencies in `pom.xml`.
- Unit-test each DAO by mocking the `Connection`/`PreparedStatement`, or use an in-memory database (H2) for integration-style DAO tests.
- Use a servlet-testing library (e.g. Mockito for `HttpServletRequest`/`HttpServletResponse`) to unit-test servlet `doGet`/`doPost` logic in isolation from Tomcat.

## Notes

- This project intentionally avoids Spring/Hibernate to demonstrate raw Servlet + JDBC fundamentals — useful for interview prep on "how does it work under the hood" questions.
- The vendored `apache-tomcat-10.1.36/` folder in this repo is a local Tomcat distribution used during development; it's not required for deployment and can be excluded via `.gitignore` if you want to slim down the repo.

## Possible Improvements

- Move raw SQL into a connection-pooled setup (e.g. HikariCP) instead of opening a new `DriverManager` connection per request.
- Hash passwords with bcrypt (verify current implementation in `UserDAO`) instead of storing/comparing plaintext, if not already done.
- Add CSRF protection on state-changing forms.
- Add proper form validation and error messaging on all JSP forms.
- Remove the vendored Tomcat distribution from version control (`.gitignore` it) to keep the repo lightweight.
