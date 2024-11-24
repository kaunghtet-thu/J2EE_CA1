package DAO;

import java.sql.*;

import DB.DatabaseUtil;
import bean.Feedback;

public class FeedbackDAO {
    // Get feedback by booking ID
    public Feedback getFeedbackByBookingId(int bookingId) {
        Feedback feedback = null;
        String sql = "SELECT * FROM feedback WHERE booking_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();
        		PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                feedback = new Feedback(
                    rs.getInt("id"),
                    rs.getInt("booking_id"),
                    rs.getInt("rating"),
                    rs.getString("comments")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedback;
    }

    // creat new  feedback
    public boolean addFeedback(int bookingId, int rating, String comments) {
        String sql = "INSERT INTO feedback (booking_id, rating, comments) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.setInt(2, rating);
            stmt.setString(3, comments);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update existing feedback
    public boolean updateFeedback(int bookingId, int rating, String comments) {
        String sql = "UPDATE feedback SET rating = ?, comments = ? WHERE booking_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, rating);
            stmt.setString(2, comments);
            stmt.setInt(3, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete feedback
    public boolean deleteFeedback(int booking_id) {
        String sql = "DELETE FROM feedback WHERE booking_id = ?";
        try (Connection connection = DatabaseUtil.getConnection();PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, booking_id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
