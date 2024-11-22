<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.util.*" %>

<%
    // Session Management
    HttpSession session = request.getSession();
    String user = (String) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin_design.css">
    <style>
        .container {
            display: flex;
            justify-content: center;
            padding: 20px;
        }

        .upload-section {
            width: 60%;
            background-color: #f8f8f8;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .upload-section h2 {
            font-size: 24px;
            margin-bottom: 15px;
        }

        .upload-section form {
            display: flex;
            flex-direction: column;
        }

        .upload-section label, .upload-section input, .upload-section textarea, .upload-section select, .upload-section button {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .upload-section button {
            background-color: brown;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .option {
            display: block;
            padding: 20px 10px;
            text-align: center;
            background-color: brown;
            color: white;
            margin: 0;
            text-decoration: none; 
            width: 100%; 
            box-sizing: border-box;
            font-size: 20px;
        }
    </style>
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
                <a href="<%= request.getContextPath() %>/login-regis/logout.jsp" class="logout2">Logout</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login2">Login</a>
            <% } %>
        </nav>
    </header>
    <a href="<%= request.getContextPath() %>/admin/admin_shop.jsp" class="option">View Your Shop</a>

    <div class="container">
        <!-- Product Upload Form -->
        <div class="upload-section">
            <h2>Upload a New Product</h2>
            <form action="<%= request.getContextPath() %>/admin/admin_upload.jsp" method="POST" enctype="multipart/form-data">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" required>

                <label for="image">Image:</label>
                <input type="file" id="image" name="image" required>

                <!-- Category Dropdown -->
                <label for="category">Category:</label>
                <select id="category" name="category" required onchange="updateItemTypes()">
                    <option value="">Select a category</option>
                    <option value="bathroom">Bathroom</option>
                    <option value="bedroom">Bedroom</option>
                    <option value="diningroom">Dining Room</option>
                    <option value="livingroom">Living Room</option>
                    <option value="office">Office</option>
                </select>

                <!-- Item Type Dropdown -->
                <label for="item_type">Item Type:</label>
                <select id="item_type" name="item_type" required>
                    <option value="">Select an item type</option>
                </select>

                <button type="submit">Upload Product</button>
            </form>
        </div>
    </div>

    <script>
        const itemTypes = {
            bathroom: ['Bathtub', 'Sink', 'Toilet Seat'],
            bedroom: ['Bed', 'Dresser', 'Nightstand'],
            diningroom: ['Accessories', 'Cabinet', 'Table'],
            livingroom: ['Coffee Table', 'Lighting', 'Sofas'],
            office: ['Chairs', 'Desk', 'Storage']
        };

        function updateItemTypes() {
            const category = document.getElementById('category').value;
            const itemTypeSelect = document.getElementById('item_type');

            itemTypeSelect.innerHTML = '<option value="">Select an item type</option>';

            if (category && itemTypes[category]) {
                itemTypes[category].forEach(item => {
                    const option = document.createElement('option');
                    option.value = item.toLowerCase().replace(/\s/g, '_');
                    option.text = item;
                    itemTypeSelect.appendChild(option);
                });
            }
        }
    </script>
</body>
</html>
