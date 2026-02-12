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

    public java.util.List<com.oceanview.models.Reservation> getAllReservations() {
        java.util.List<com.oceanview.models.Reservation> list = new java.util.ArrayList<>();
        String query = "SELECT * FROM reservations ORDER BY reservation_no DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             java.sql.ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("reservation_no");
                String name = rs.getString("guest_name");
                String room = rs.getString("room_type");
                String inDate = rs.getString("check_in_date");
                String outDate = rs.getString("check_out_date");
                String contact = rs.getString("contact_number");

                list.add(new com.oceanview.models.Reservation(id, name, room, inDate, outDate, contact));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}