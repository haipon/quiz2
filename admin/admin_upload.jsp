<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    // Enable error reporting for debugging
    boolean errorReporting = true; // Set to false in production
    if (errorReporting) {
        pageContext.setAttribute("javax.servlet.error.reporting", true);
    }

    // Session management
    HttpSession session = request.getSession();
    Integer adminId = (Integer) session.getAttribute("admin_id");

    if (adminId == null) {
        out.println("Admin ID is not set in the session.");
        return;
    }

    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/u260447614_ab";
    String dbUser = "u260447614_cd";
    String dbPassword = "Midterm711";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Check if form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Retrieve form data
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String itemType = request.getParameter("item_type");

            // Validate required fields
            if (name == null || description == null || category == null || itemType == null) {
                out.println("All fields are required.");
                return;
            }

            // File upload handling
            String uploadDir = application.getRealPath("/") + "uploads";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists() && !uploadDirFile.mkdirs()) {
                out.println("Failed to create upload directory.");
                return;
            }

            String image = null;
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
            } else {
                out.println("Image file not provided.");
                return;
            }

            // Insert product into the database
            String sql = "INSERT INTO products (name, description, price, image, category, item_type, admin_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setDouble(3, price);
            stmt.setString(4, image);
            stmt.setString(5, category);
            stmt.setString(6, itemType);
            stmt.setInt(7, adminId);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // Redirect based on item type
                String redirectURL;
                switch (itemType.toLowerCase()) {
                    case "bathtub":
                        redirectURL = "d_bathroom/d_bathtub.jsp";
                        break;
                    case "sink":
                        redirectURL = "d_bathroom/d_sinks.jsp";
                        break;
                    case "toilet_seat":
                        redirectURL = "d_bathroom/d_toiletseats.jsp";
                        break;
                    case "bed":
                        redirectURL = "d_bedroom/d_bed.jsp";
                        break;
                    case "dresser":
                        redirectURL = "d_bedroom/d_dresser.jsp";
                        break;
                    case "nightstand":
                        redirectURL = "d_bedroom/d_nightstand.jsp";
                        break;
                    case "accessories":
                        redirectURL = "d_diningroom/d_accessories.jsp";
                        break;
                    case "cabinet":
                        redirectURL = "d_diningroom/d_cabinet.jsp";
                        break;
                    case "table":
                        redirectURL = "d_diningroom/d_table.jsp";
                        break;
                    case "coffee_table":
                        redirectURL = "d_livingroom/d_coffeetable.jsp";
                        break;
                    case "lighting":
                        redirectURL = "d_livingroom/d_lighting.jsp";
                        break;
                    case "sofas":
                        redirectURL = "d_livingroom/d_sofas.jsp";
                        break;
                    case "chairs":
                        redirectURL = "d_office/d_chairs.jsp";
                        break;
                    case "desk":
                        redirectURL = "d_office/d_desk.jsp";
                        break;
                    case "storage":
                        redirectURL = "d_office/d_storage.jsp";
                        break;
                    default:
                        out.println("Invalid item type.");
                        return;
                }
                response.sendRedirect(redirectURL + "?success=1");
                return;
            } else {
                out.println("Error inserting product.");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
