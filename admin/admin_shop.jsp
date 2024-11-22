<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    // Enable session
    HttpSession session = request.getSession();
    Integer adminId = (Integer) session.getAttribute("admin_id");

    if (adminId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/u260447614_ab";
    String dbUser = "u260447614_cd";
    String dbPassword = "Midterm711";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Fetch products for the logged-in admin
        String sql = "SELECT * FROM products WHERE admin_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, adminId);
        rs = stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Your Shop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/admin_design.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f0f0;
        }

        .container {
            display: flex;
            justify-content: center;
            padding: 20px;
            max-width: 1200px;
            margin: auto;
        }

        .product-list {
            width: 100%;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 24px;
            margin-bottom: 15px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: brown;
            color: white;
        }

        .edit-btn, .delete-btn {
            background-color: blue;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin: 0 5px;
            text-decoration: none;
        }

        .delete-btn {
            background-color: red;
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
            font-size: 20px
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
            <% if (session.getAttribute("user") != null) { %>
                <a href="<%= request.getContextPath() %>/login-regis/logout.jsp" class="logout2">Logout</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login2">Login</a>
            <% } %>
        </nav>
    </header>
    
    <a href="<%= request.getContextPath() %>/admin/admin_panel.jsp" class="option">Upload A Product</a>

    <div class="container">
        <!-- Product List -->
        <div class="product-list">
            <h2>Your Products</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Picture</th>
                    <th>Product Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <%
                    try {
                        if (rs != null) {
                            while (rs.next()) {
                %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td><img src="<%= request.getContextPath() %>/uploads/<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>" width="100"></td>
                                    <td><%= rs.getString("name") %></td>
                                    <td><a href="<%= request.getContextPath() %>/edit_product.jsp?id=<%= rs.getInt("id") %>" class="edit-btn">Edit</a></td>
                                    <td>
                                        <form action="<%= request.getContextPath() %>/delete_product.jsp" method="POST" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="delete-btn">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                <%
                            }
                        } else {
                %>
                            <tr><td colspan="5">No products found.</td></tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
