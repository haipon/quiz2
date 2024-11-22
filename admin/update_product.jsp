<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*" %>

<%
    // Initialize database connection variables
    String dbURL = "jdbc:mysql://localhost:3306/u260447614_ab";
    String dbUser = "u260447614_cd";
    String dbPassword = "Midterm711";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Check if the form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String itemType = request.getParameter("item_type");

            // Handle image upload if a new image is provided
            String image = null;
            String uploadDir = application.getRealPath("/") + "uploads";
            File uploadDirFile = new File(uploadDir);

            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                image = filePart.getSubmittedFileName();
                String targetPath = uploadDir + File.separator + image;
                try (InputStream input = filePart.getInputStream();
                     FileOutputStream output = new FileOutputStream(targetPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }
            }

            // Build the SQL query
            String sql;
            if (image != null) {
                sql = "UPDATE products SET name=?, description=?, price=?, image=?, category=?, item_type=? WHERE id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, description);
                stmt.setDouble(3, price);
                stmt.setString(4, image);
                stmt.setString(5, category);
                stmt.setString(6, itemType);
                stmt.setInt(7, id);
            } else {
                sql = "UPDATE products SET name=?, description=?, price=?, category=?, item_type=? WHERE id=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, description);
                stmt.setDouble(3, price);
                stmt.setString(4, category);
                stmt.setString(5, itemType);
                stmt.setInt(6, id);
            }

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("Product updated successfully!");
                response.sendRedirect("admin_shop.jsp");
            } else {
                out.println("Error updating product.");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close the database connection
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
