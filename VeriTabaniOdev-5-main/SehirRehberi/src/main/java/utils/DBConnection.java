package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5433/EmiraGeziDB";
    private static final String USER = "postgres";
    private static final String PASSWORD = "";
    public static Connection getConnection() {
        try {
            // PostgreSQL sürücüsünü yüklüyoruz
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Sürücüsü bulunamadı: " + e.getMessage());
            return null;
        } catch (SQLException e) {
            System.out.println("Veritabanı bağlantı hatası: " + e.getMessage());
            return null;
        }
    }
}