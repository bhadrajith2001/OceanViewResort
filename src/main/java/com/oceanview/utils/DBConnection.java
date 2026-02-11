package com.oceanview.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Singleton Pattern:
    private static Connection connection = null;

    // MySQL username , password
    private static final String URL = "jdbc:mysql://localhost:3306/ocean_view_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";


    private DBConnection() {
    }

    public static Connection getConnection() {
        if (connection == null) {
            try {

                Class.forName("com.mysql.cj.jdbc.Driver");

                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database Connected Successfully!");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                System.out.println("Database Connection Failed!");
            }
        }
        return connection;
    }
}