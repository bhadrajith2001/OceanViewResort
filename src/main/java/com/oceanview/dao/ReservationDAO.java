package com.oceanview.dao;

import com.oceanview.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReservationDAO {

    public boolean addReservation(String name, String address, String contact, String roomType, String checkIn, String checkOut) {
        String query = "INSERT INTO reservations (guest_name, address, contact_number, room_type, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, contact);
            stmt.setString(4, roomType);
            stmt.setString(5, checkIn);
            stmt.setString(6, checkOut);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        }
    }

}