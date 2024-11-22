<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Use the built-in session object
    String user = (String) session.getAttribute("user");

    // Database connection
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/u260447614_ab", "u260447614_cd", "Midterm711");

        // Fetch all coffee tables from the database
        String sql = "SELECT * FROM products WHERE item_type = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, "coffee_table");
        rs = stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Coffee Table Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/design.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/display_furniture/display_design.css">
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
        <% if (user != null) { %>
            <a href="<%= request.getContextPath() %>/login-regis/logout.jsp" class="logout">Logout</a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login">Login</a>
        <% } %>
    </nav>
</header>

<h2 class="Title2">COFFEE TABLE</h2>
<div class="search-bar">
    <input type="text" placeholder="Search...">
    <button class="search-btn">🔍</button>
</div>

<div class="furniture-grid">
    <%
        if (rs != null) {
            boolean hasResults = false;
            while (rs.next()) {
                hasResults = true;
    %>
                <div class="furniture-card">
                    <img src="<%= request.getContextPath() %>/admin/uploads/<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>">
                    <div class="card-content">
                        <h2><%= rs.getString("name") %></h2>
                        <p><%= rs.getString("description") %></p>
                        <div class="price">
                            <span class="currency">Rp</span>
                            <span class="amount"><%= String.format("%,d", rs.getInt("price")) %></span>
                        </div>
                        <form method="post" action="<%= request.getContextPath() %>/cart.jsp">
                            <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="addCart">Add to Cart</button>
                        </form>
                        <form method="post" action="<%= request.getContextPath() %>/wishlist.jsp">
                            <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
                            <input type="hidden" name="action" value="add_to_wishlist">
                            <button type="submit" class="wishlist"><i class="fa-regular fa-heart"></i></button>
                        </form>
                        <button class="comment"><i class="fa-regular fa-comment"></i></button>
                    </div>
                </div>
    <%
            }
            if (!hasResults) {
    %>
                <p>No coffee tables found.</p>
    <%
            }
        }
    %>
</div>

<main>
</main>

<%
    // Close database resources
    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
%>
</body>
</html>
