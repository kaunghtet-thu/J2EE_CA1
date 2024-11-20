package DAO;

import DB.DatabaseUtil;
import bean.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Create: Add a new booking
    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO booking (member_id, service_id, status_id, staff_id, booking_date, booking_time, booked_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, booking.getMemberId());
            stmt.setInt(2, booking.getServiceId());
            stmt.setInt(3, booking.getStatusId());
            stmt.setObject(4, booking.getStaffId(), Types.INTEGER); // Handle optional field
            stmt.setDate(5, Date.valueOf(booking.getBookingDate()));
            stmt.setTime(6, Time.valueOf(booking.getBookingTime()));
            stmt.setTimestamp(7, Timestamp.valueOf(booking.getBookedAt()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read: Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM booking";

        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("id"),
                        rs.getInt("member_id"),
                        rs.getInt("service_id"),
                        rs.getInt("status_id"),
                        rs.getObject("staff_id", Integer.class),
                        rs.getDate("booking_date").toLocalDate(),
                        rs.getTime("booking_time").toLocalTime(),
                        rs.getTimestamp("booked_at").toLocalDateTime()
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Update: Update booking status
    public boolean updateBookingStatus(int id, int statusId) {
        String sql = "UPDATE booking SET status_id = ? WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, statusId);
            stmt.setInt(2, id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete: Remove a booking by ID
    public boolean deleteBooking(int id) {
        String sql = "DELETE FROM booking WHERE id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
