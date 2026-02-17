package com.oceanview.dao;

import com.oceanview.utils.DBConnection;
import com.oceanview.models.Reservation; // Model එක Import කළා
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // 1. Add Reservation
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

    // 2. Get All Reservations
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();


        String query = "SELECT r.*, rr.price_per_night " +
                "FROM reservations r " +
                "JOIN room_rates rr ON r.room_type = rr.room_type " +
                "ORDER BY r.reservation_no DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("reservation_no");
                String name = rs.getString("guest_name");
                String room = rs.getString("room_type");
                String inDate = rs.getString("check_in_date");
                String outDate = rs.getString("check_out_date");
                String contact = rs.getString("contact_number");
                String status = rs.getString("status");


                double rate = rs.getDouble("price_per_night");


                Reservation r = new Reservation(id, name, room, inDate, outDate, contact, rate);
                r.setStatus(status);

                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Delete Reservation
    public boolean deleteReservation(int id) {
        String query = "DELETE FROM reservations WHERE reservation_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 4. Room Availability Check
    public boolean isRoomAvailable(String roomType, String checkIn, String checkOut) {

        // ✅ Status not 'Cancelled'then Count
        String query = "SELECT COUNT(*) FROM reservations WHERE room_type = ? AND check_in_date < ? AND check_out_date > ? AND status != 'Cancelled'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, roomType);
            stmt.setString(2, checkOut);
            stmt.setString(3, checkIn);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count == 0; // Count 0(Available)
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //Cancel Reservation
    public boolean cancelReservation(int id) {
        String query = "UPDATE reservations SET status = 'Cancelled' WHERE reservation_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}