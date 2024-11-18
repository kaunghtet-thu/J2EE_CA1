package DAO;

import model.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DB.DatabaseUtil;


public class MemberDAO {
	public Member getMemberById(int id) {
        String sql = "SELECT * FROM member WHERE id = ?";
        
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String name = rs.getString("name");
                int role_id = rs.getInt("role_id");
                return new Member(id, name, role_id);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
	
	public Member loginMember(String email, String password) {
	    String sql = "SELECT * FROM member WHERE email = ? AND password = ?";

	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {
	         
	        // Set parameters
	        stmt.setString(1, email);
	        stmt.setString(2, password);

	        // Execute query
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	            	
	                // Retrieve member details
	                int id = rs.getInt("id");
	                String name = rs.getString("name");
	                int roleId = rs.getInt("role_id");
	                
	                // Return new Member object
	                return new Member(id, name, roleId);
	            }
	        }

	    } catch (SQLException e) {
	        System.err.println("Error while logging in: " + e.getMessage());
	    }

	    // Return null if no member found or error occurs
	    return null;
	}

	
}
