package concreteClasses;

import java.sql.Connection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {
    private static Connection conn;
    private static final String db_username = "root";
    private static final String db_password = "";
    private static final String url = "jdbc:mysql://localhost/temaribet";
    
    public static Connection getConnection() throws Exception
    {
        if(conn==null)
        {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = (Connection) DriverManager.getConnection(url, db_username, db_password);
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
                throw new Exception(ex.getMessage());
            }
        }
        
        return conn;
    }    
}