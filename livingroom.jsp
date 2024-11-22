<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Use the built-in session object to check if the user is logged in
    String user = (String) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Living Room Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/design.css">
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

    <h2 class="Title">LIVING ROOM FURNITURES</h2>
    <h3 class="pick">Choose Your Desired Category</h3>

    <div class="image-container">
        <a href="<%= request.getContextPath() %>/display_furniture/d_livingroom/d_sofas.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/s.png" alt="Sofas">
            <h2>Sofas</h2>
            <p>Experience comfort and style with our diverse 
                selection of sofas. Whether you prefer a cozy 
                loveseat or a spacious sectional, we have the perfect 
                fit for your living room.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_livingroom/d_coffeetable.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/coffeetable.png" alt="Coffee Table">
            <h2>Coffee Table</h2>
            <p>Add a touch of elegance and functionality to your space with 
                our beautifully crafted coffee tables. Ideal for displaying 
                décor or keeping your essentials within easy reach.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_livingroom/d_lighting.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/lamp.png" alt="Lighting">
            <h2>Lighting</h2>
            <p>Brighten up your home with our unique lighting options. 
                From sleek floor lamps to eye-catching chandeliers, 
                find the perfect fixture to set the mood in any room.
            </p>
        </a>
    </div>
</body>
</html>
