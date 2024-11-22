<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/u260447614_ab";
    String dbUser = "u260447614_cd";
    String dbPassword = "Midterm711";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    HttpSession session = request.getSession();
    Integer userId = (Integer) session.getAttribute("user_id"); // User ID from session
    String sessionToken = session.getId(); // Session token for non-logged-in users

    if (userId == null) {
        userId = 0; // Default to 0 if not logged in
    }

    List<Map<String, Object>> cartItems = new ArrayList<>();
    double subtotal = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Fetch cart items
        String sql = "SELECT c.id AS cart_id, p.name, p.price, p.image, c.quantity " +
                     "FROM cart c " +
                     "JOIN products p ON c.product_id = p.id " +
                     "WHERE c.user_id = ? OR c.session_token = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        stmt.setString(2, sessionToken);
        rs = stmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("cart_id", rs.getInt("cart_id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getDouble("price"));
            item.put("image", rs.getString("image"));
            item.put("quantity", rs.getInt("quantity"));
            subtotal += rs.getDouble("price") * rs.getInt("quantity");
            cartItems.add(item);
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
<html>
<head>
    <title>Cart Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/design.css">
    <style>
        .quantity-container {
            display: flex;
            align-items: center;
        }
        .quantity-btn {
            width: 30px;
            height: 30px;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            border: 1px solid #ddd;
            cursor: pointer;
            font-size: 16px;
            background-color: #f0f0f0;
        }
        .quantity {
            margin: 0 10px;
            font-size: 16px;
        }
        .remove-btn {
            background-color: #f00;
            color: #fff;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
        .cart-subtotal {
            margin-top: 45px;
            text-align: center;
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
            <a href="<%= request.getContextPath() %>/cart.jsp" class="active">Cart</a>
            <% if (session.getAttribute("user") != null) { %>
                <a href="<%= request.getContextPath() %>/login-regis/logout.jsp" class="logout">Logout</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login-regis/login.jsp" class="login">Login</a>
            <% } %>
        </nav>
    </header>

    <h2 class="Title2">CART</h2>
    <table class="cart-table">
        <thead>
            <tr>
                <th>Item Image</th>
                <th>Item Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% if (!cartItems.isEmpty()) { %>
                <% for (Map<String, Object> item : cartItems) { %>
                    <tr>
                        <td>
                            <img src="<%= request.getContextPath() %>/admin/uploads/<%= item.get("image") %>" alt="<%= item.get("name") %>" style="width: 150px; height: auto;">
                        </td>
                        <td><%= item.get("name") %></td>
                        <td>Rp <%= String.format("%,.0f", item.get("price")) %></td>
                        <td>
                            <div class="quantity-container">
                                <form method="post" action="<%= request.getContextPath() %>/cart.jsp" class="quantity-form">
                                    <input type="hidden" name="cart_id" value="<%= item.get("cart_id") %>">
                                    <input type="hidden" name="action" value="decrease">
                                    <button type="submit" class="quantity-btn">-</button>
                                </form>
                                
                                <span class="quantity"><%= item.get("quantity") %></span>
                                
                                <form method="post" action="<%= request.getContextPath() %>/cart.jsp" class="quantity-form">
                                    <input type="hidden" name="cart_id" value="<%= item.get("cart_id") %>">
                                    <input type="hidden" name="action" value="increase">
                                    <button type="submit" class="quantity-btn">+</button>
                                </form>
                            </div>
                        </td>
                        <td>
                            <form method="post" action="<%= request.getContextPath() %>/cart.jsp">
                                <input type="hidden" name="remove_cart_id" value="<%= item.get("cart_id") %>">
                                <button type="submit" class="remove-btn">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="5">Your cart is empty.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <div class="cart-subtotal">
        <h3>Subtotal: Rp <%= String.format("%,.0f", subtotal) %></h3>
    </div>
</body>
</html>
