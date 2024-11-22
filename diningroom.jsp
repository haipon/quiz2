<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Use the built-in session object directly to check if the user is logged in
    String user = (String) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dining Room Page</title>
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

    <h2 class="Title">DINING ROOM FURNITURES</h2>
    <h3 class="pick">Choose Your Desired Category</h3>

    <div class="image-container">
        <a href="<%= request.getContextPath() %>/display_furniture/d_diningroom/d_cabinet.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/woodencabinet.png" alt="Cabinets">
            <h2>Cabinets</h2>
            <p>Transform your kitchen with our exquisite selection of cabinets. 
                With diverse styles and finishes, find the perfect blend of 
                practicality and elegance to enhance your culinary space.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_diningroom/d_table.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/diningtable.png" alt="Dining Tables">
            <h2>Dining Tables</h2>
            <p>Gather around our stunning dining tables, 
                where style meets functionality. 
                From rustic charm to modern elegance, 
                discover the perfect centerpiece for your dining experience.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_diningroom/d_accessories.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/mug.png" alt="Accessories">
            <h2>Accessories</h2>
            <p>Spruce up your kitchen with our delightful range of accessories! 
                From stylish mugs to handy utensils, find the perfect pieces that
                add personality and charm to your cooking space.
            </p>
        </a>
    </div>
</body>
</html>
