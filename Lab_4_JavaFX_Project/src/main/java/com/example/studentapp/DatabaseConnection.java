package com.example.studentapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC connection helper for Microsoft SQL Server.
 * Update the URL, USER and PASSWORD values to match your own SQL Server setup.
 */
public class DatabaseConnection {

    // localhost = SQL Server running on your own computer
    // 1433       = default port of SQL Server
    // encrypt=false disables SSL if not configured
    private static final String URL  =
            "jdbc:sqlserver://localhost:1433;databaseName=StudentInformation;encrypt=false;";
    private static final String USER = "sa";
    private static final String PASSWORD = "your_password"; // replace with your own SQL Server password

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
