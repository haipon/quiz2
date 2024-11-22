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
    <title>Office Page</title>
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

    <h2 class="Title">OFFICE FURNITURES</h2>
    <h3 class="pick">Choose Your Desired Category</h3>

    <div class="image-container">
        <a href="<%= request.getContextPath() %>/display_furniture/d_office/d_desk.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/officedesk.png" alt="Desks">
            <h2>Desks</h2>
            <p>Revamp your workspace with our stylish, 
                pre-loved office desks. Each desk offers a 
                unique character and sturdy design, perfect for 
                enhancing productivity while supporting sustainable choices.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_office/d_chairs.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/officechair.png" alt="Chairs">
            <h2>Chairs</h2>
            <p>Discover the perfect blend of comfort and style with our 
                collection of used office chairs. Designed for ergonomic support, 
                these chairs will keep you productive without compromising on aesthetics.
            </p>
        </a>

        <a href="<%= request.getContextPath() %>/display_furniture/d_office/d_storage.jsp" class="image-card">
            <img src="<%= request.getContextPath() %>/images/officestorage.png" alt="Storage">
            <h2>Storage</h2>
            <p>Maximize your office 
                organization with our selection of 
                used storage solutions. From charming filing cabinets 
                to versatile shelves, each piece combines functionality with 
                sustainability to enhance your workspace.
            </p>
        </a>
    </div>
</body>
</html>
