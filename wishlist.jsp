<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/u260447614_ab";
    String dbUser = "u260447614_cd";
    String dbPassword = "Midterm711";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> wishlistItems = new ArrayList<>();
    HttpSession session = request.getSession();
    Integer userId = (Integer) session.getAttribute("user_id"); // Assuming user_id is stored in session

    if (userId == null) {
        userId = 1; // Default to user_id 1 if not logged in
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Fetch wishlist items for the user
        String sql = "SELECT w.id AS wishlist_id, p.id AS product_id, p.name, p.price, p.image " +
                     "FROM wishlist w JOIN products p ON w.product_id = p.id WHERE w.user_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("wishlist_id", rs.getInt("wishlist_id"));
            item.put("product_id", rs.getInt("product_id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getDouble("price"));
            item.put("image", rs.getString("image"));
            wishlistItems.add(item);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
    <title>Wishlist | SAVICLE</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/design.css">
    <style>
        .wishlist-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .pick {
            font-size: 2.5em;
            color: #72383d;
            margin-bottom: 30px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        td img {
            width: 100px;
            height: auto;
        }

        td {
            text-align: center;
        }

        .action-btns {
            text-align: center;
        }

        .add-btn, .remove-btn {
            background-color: #72383d;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
            font-weight: 500;
            transition: background-color 0.3s ease;
            display: inline-block;
            margin: 0 5px;
        }

        .add-btn:hover {
            background-color: #ab644b;
        }

        .remove-btn {
            background-color: #d7e1f3;
            color: #6F3F3A;
        }

        .remove-btn:hover {
            background-color: #d2bba4;
        }

        @media (max-width: 768px) {
            th, td {
                font-size: 14px;
                padding: 10px;
            }
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
            <a href="<%= request.getContextPath() %>/wishlist.jsp" class="active">Wishlist</a>
            <a href="<%= request.getContextPath() %>/cart.jsp">Cart</a>
            
            <% if (session.getAttribute("user") != null) { %>
                <a href="<%= request.getContextPath() %>/login-regis/logout.jsp" class="logout">Logout</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login">Login</a>
            <% } %>
        </nav>
    </header>

    <div class="wishlist-container">
        <h2 class="pick">Your Wishlist</h2>
        <table>
            <thead>
                <tr>
                    <th>Item Image</th>
                    <th>Item Name</th>
                    <th>Unit Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (wishlistItems.size() > 0) { %>
                    <% for (Map<String, Object> item : wishlistItems) { %>
                        <tr>
                            <td><img src="<%= request.getContextPath() %>/admin/uploads/<%= item.get("image") %>" alt="<%= item.get("name") %>"></td>
                            <td><%= item.get("name") %></td>
                            <td>RP<%= String.format("%,.2f", item.get("price")) %></td>
                            <td class="action-btns">
                                <form method="post" action="<%= request.getContextPath() %>/cart.jsp" style="display:inline;">
                                    <input type="hidden" name="action" value="add_to_cart">
                                    <input type="hidden" name="product_id" value="<%= item.get("product_id") %>">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit" class="add-btn">Add to Cart</button>
                                </form>

                                <form method="post" action="<%= request.getContextPath() %>/wishlist.jsp" style="display:inline;">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="wishlist_id" value="<%= item.get("wishlist_id") %>">
                                    <button type="submit" class="remove-btn">Remove</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="4">No items in your wishlist.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
