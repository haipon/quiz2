<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Use the built-in session object directly
    String user = (String) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bathroom Page</title>
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

    <h2 class="Title">BATHROOM FURNITURES</h2>
    <h3 class="pick">Choose Your Desired Category</h3>

    <div class="image-container">
        <a href="<%= request.getContextPath() %>/display_furniture/d_bathroom/d_bathtub.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/bathtub.png" alt="Bathtubs">
            <h2>Bathtubs</h2>
            <p>Refresh your bathroom with our quality bathtubs. Explore our range of vintage, freestanding, and modern styles to find the perfect fit for your home....</p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_bathroom/d_sinks.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/sink.png" width="100px" alt="Sinks">
            <h2>Sinks</h2>
            <p>Uncover a diverse range of secondhand sinks that combine charm and utility, perfect for enhancing your space....</p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_bathroom/d_toiletseats.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/browntoilet.png" alt="Toilet Seats">
            <h2>Toilet Seats</h2>
            <p>Explore our collection of stylish toilet seats that offer both comfort and elegance for your bathroom....</p>
        </a>
    </div>
</body>
</html>
