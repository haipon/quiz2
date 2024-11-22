<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // The built-in session object can be used directly
    String user = (String) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bedroom Furniture Page</title>
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

    <h2 class="Title">BEDROOM FURNITURES</h2>
    <h3 class="pick">Choose Your Desired Category</h3>

    <div class="image-container">
        <a href="<%= request.getContextPath() %>/display_furniture/d_bedroom/d_bed.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/bed.png" alt="Beds">
            <h2>Beds</h2>
            <p>Experience restful nights and timeless design
            with our varied selection of beds. From snug platform styles
            to grand canopy options, we have the ideal piece to transform your bedroom.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_bedroom/d_nightstand.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/nightstand.png" alt="Nightstands">
            <h2>Nightstands</h2>
            <p>Enhance your bedroom with our stylish nightstands,
            offering both practicality and elegance. Whether you need extra storage
            or a chic surface for your essentials, we have the perfect option to
            complement your space.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_bedroom/d_dresser.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/Dressers.png" alt="Dressers">
            <h2>Dressers</h2>
            <p>Elevate your storage solutions with our collection of dressers, blending
            functionality with stylish design. From sleek modern pieces to classic styles, find the perfect
            addition to organize your essentials beautifully.
            </p>
        </a>
    </div>
</body>
</html>
