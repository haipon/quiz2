import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnector {
    // Update with your actual database information
    private static final String URL = "jdbc:mysql://localhost:3306/your_database?useSSL=false&serverTimezone=UTC";
    private static final String USER = "your_username";
    private static final String PASSWORD = "your_password";

    public static Connection getConnection() throws SQLException {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Print error stack trace
            throw new SQLException("JDBC Driver not found!", e); // Throw SQLException with the cause
        }

        // Establish and return the connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
