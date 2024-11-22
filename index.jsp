<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.quiz2.database.DBConnector" %>

<%
    // Check if the user is logged in using the built-in session object
    String user = (String) session.getAttribute("user");
    if (user != null) {
        // Redirect to admin page if the user is logged in
        response.sendRedirect(request.getContextPath() + "/admin/admin_index.jsp");
        return;
    }

    // Database connection and data retrieval
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnector.getConnection(); // Get database connection
        stmt = conn.createStatement();
        
        // Query to fetch furniture categories (example query)
        rs = stmt.executeQuery("SELECT category_name FROM furniture_categories");

        // Prepare dynamic navigation links for furniture categories
        StringBuilder furnitureLinks = new StringBuilder();
        while (rs.next()) {
            String categoryName = rs.getString("category_name");
            String categoryLink = request.getContextPath() + "/" + categoryName.toLowerCase() + ".jsp";
            furnitureLinks.append("<a href='").append(categoryLink).append("'>").append(categoryName).append("</a>");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/home_design.css">
    </head>
    <body>
        <header>
            <h1 class="header">SAVICLE</h1>
            <nav>
                <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
                <div class="dropdown">
                    <h2 class="dropbtn">Furniture</h2>
                    <div class="dropdown-content">
                        <!-- Dynamic furniture links from database -->
                        <%= furnitureLinks.toString() %>
                    </div>
                </div>
                <a href="<%= request.getContextPath() %>/wishlist.jsp">Wishlist</a>
                <a href="<%= request.getContextPath() %>/cart.jsp">Cart</a>
                <% if (user != null) { %>
                    <a href="<%= request.getContextPath() %>/login-regis/logout.jsp" class="login">Logout</a>
                <% } else { %>
                    <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login">Login</a>
                <% } %>
            </nav>
        </header>
        <div class="homepage">
            <h2>Giving Furniture a <br> Second Chance</h2>
            <p>SAVICLE saves and recycles beautifully crafted furniture, offering timeless <br>
                pieces that feel as good as they look, all while giving them a new life in your home.</p>
            <img src="<%= request.getContextPath() %>/images/homepage.png" class="home" alt="Homepage Furniture">
        </div>
    </body>
</html>
