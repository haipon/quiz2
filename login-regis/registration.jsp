<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.ArrayList" %>

<%
    // Check if the user is already logged in
    if (session.getAttribute("user") != null) {
        response.sendRedirect("/index.jsp");
        return;
    }

    String fullName = request.getParameter("fullname");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String passwordRepeat = request.getParameter("repeat_password");
    ArrayList<String> errors = new ArrayList<>();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (fullName == null || fullName.isEmpty() || 
            email == null || email.isEmpty() || 
            password == null || password.isEmpty() || 
            passwordRepeat == null || passwordRepeat.isEmpty()) {
            errors.add("All fields are required");
        }

        if (email != null && !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            errors.add("Email is not valid");
        }

        if (password != null && password.length() < 8) {
            errors.add("Password must be at least 8 characters long");
        }

        if (password != null && passwordRepeat != null && !password.equals(passwordRepeat)) {
            errors.add("Passwords do not match");
        }

        if (errors.isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Connect to the database
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");

                // Check if email already exists
                String checkEmailSql = "SELECT * FROM user WHERE email = ?";
                stmt = conn.prepareStatement(checkEmailSql);
                stmt.setString(1, email);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    errors.add("Email already exists");
                } else {
                    // Insert the new user
                    String insertSql = "INSERT INTO user (full_name, email, password) VALUES (?, ?, ?)";
                    stmt = conn.prepareStatement(insertSql);
                    stmt.setString(1, fullName);
                    stmt.setString(2, email);
                    stmt.setString(3, password); // Use hashing for production
                    stmt.executeUpdate();

                    request.setAttribute("successMessage", "You are registered successfully.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                errors.add("Something went wrong: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1 class="header">SAVICLE</h1>
        <nav>
            <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
            <div class="dropdown">
                <h2 class="dropbtn">Furniture</h2>
                <div class="dropdown-content">
                    <a href="<%= request.getContextPath() %>/office.jsp">Office</a>
                    <a href="<%= request.getContextPath() %>/livingroom.jsp">Living Room</a>
                    <a href="<%= request.getContextPath() %>/diningroom.jsp">Dining Room</a>
                    <a href="<%= request.getContextPath() %>/bedroom.jsp">Bedroom</a>
                    <a href="<%= request.getContextPath() %>/bathroom.jsp">Bathroom</a>
                </div>
            </div>
            <a href="<%= request.getContextPath() %>/wishlist.jsp">Wishlist</a>
            <a href="<%= request.getContextPath() %>/cart.jsp">Cart</a>
            <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login">Login</a>
        </nav>
    </header>

    <div class="container">
        <% if (!errors.isEmpty()) { %>
            <% for (String error : errors) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>
        <% } %>

        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
        <% } %>

        <form action="registration.jsp" method="post">
            <div class="form-group">
                <input type="text" class="form-control" name="fullname" placeholder="Full Name" value="<%= fullName != null ? fullName : "" %>" required>
            </div>
            <div class="form-group">
                <input type="email" class="form-control" name="email" placeholder="Email" value="<%= email != null ? email : "" %>" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="repeat_password" placeholder="Repeat Password" required>
            </div>
            <div class="form-btn">
                <input type="submit" class="custom-btn" value="Register" name="submit">
            </div>
        </form>
        <div class="click">
            <a href="login.jsp">Login Here</a>
        </div>
    </div>
</body>
</html>
