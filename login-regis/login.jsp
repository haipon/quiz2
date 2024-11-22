<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Use the built-in session object directly
    if (session.getAttribute("user") != null) {
        response.sendRedirect("/index.jsp");
        return;
    }

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Handle form submission
    if (request.getParameter("login") != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "your_username", "your_password");

            // Prepare SQL statement
            String sql = "SELECT * FROM user WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Check if the password matches
                String hashedPassword = rs.getString("password");
                if (password.equals(hashedPassword)) { // Replace with a proper hashing check (e.g., BCrypt)
                    // Log in the user and redirect to homepage
                    session.setAttribute("user", rs.getString("email"));
                    session.setAttribute("admin_id", rs.getInt("id")); // Assuming you want to store user ID
                    response.sendRedirect("index.jsp");
                    return;
                } else {
                    request.setAttribute("errorMessage", "Incorrect password.");
                }
            } else {
                request.setAttribute("errorMessage", "No user found with that email.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
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
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <form action="login.jsp" method="post">
            <div class="form-group">
                <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            <div class="form-btn">
                <input type="submit" class="custom-btn" value="Login" name="login">
            </div>
        </form>
        <div class="click">
            <a href="registration.jsp">Register Here</a>
        </div>
    </div>
</body>
</html>
