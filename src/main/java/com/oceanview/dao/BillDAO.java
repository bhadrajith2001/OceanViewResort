package com.oceanview.dao;

import com.oceanview.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BillDAO {

    // bill Save
    public boolean saveBill(int reservationId, String guestName, double amount) {

        if (isBillExists(reservationId)) {
            return true;
        }

        String query = "INSERT INTO bills (reservation_id, guest_name, total_amount) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, reservationId);
            stmt.setString(2, guestName);
            stmt.setDouble(3, amount);

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //billed Method
    private boolean isBillExists(int reservationId) {
        String query = "SELECT bill_id FROM bills WHERE reservation_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, reservationId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            return false;
        }
    }

    //all bill to dashboard
    public int getTotalBillsCount() {
        String query = "SELECT COUNT(*) FROM bills";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}