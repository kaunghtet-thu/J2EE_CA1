package DAO;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import DB.DatabaseUtil;
import bean.*;
import jakarta.servlet.http.HttpSession;

public class MemberDAO {
	private String tableName = "member";
	private final String TABLENAME2 = "address";
	private final String TABLENAME3 = "role";
	
	  private void setSession(HttpSession session, Member member, int actorId) {
		  if (member.getId()==actorId)
	        session.setAttribute("member", member);
	  }
	  
	  public static String hashPassword(String password) {
	        try {
	            MessageDigest md = MessageDigest.getInstance("SHA-256");
	            byte[] hashBytes = md.digest(password.getBytes());
	            StringBuilder hexString = new StringBuilder();
	            for (byte b : hashBytes) {
	                hexString.append(String.format("%02x", b));
	            }
	            return hexString.toString();
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	        }
	        return null;
	    }
	//======================================
	// CREATE
	//======================================
	public Member createMember(String name, String email, String hashedPassword, String phone) {
	    String sql = String.format("INSERT INTO %s (name, email, password, phone, role_id) VALUES (?, ?, ?, ?, 2)", this.tableName);

	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

	        stmt.setString(1, name);
	        stmt.setString(2, email);
	        stmt.setString(3, hashedPassword);
	        stmt.setString(4, phone);

	        int rowsAffected = stmt.executeUpdate();

	        // Check if a row was inserted
	        if (rowsAffected > 0) {
	            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
	                if (generatedKeys.next()) {
	                    int id = generatedKeys.getInt(1);  
	                    return new Member(id, name, 1);
	                }
	            }
	        }

	    } catch (SQLException e) {
	        System.err.println("Error while creating member: " + e.getMessage());
	    }

	    return null;
	}

	public boolean addMemberAddress (int memberId, String address) {
		 String sql = String.format("INSERT INTO %s (member_id, address) VALUES (?, ?)", this.TABLENAME2);

		    try (Connection connection = DatabaseUtil.getConnection();
		         PreparedStatement stmt = connection.prepareStatement(sql)) {

		        stmt.setInt(1, memberId);
		        stmt.setString(2, address);

		        int rowsAffected = stmt.executeUpdate();

		        // Check if a row was inserted
		        if (rowsAffected > 0) {
		            return true;
		        }

		    } catch (SQLException e) {
		        System.err.println("Error while creating member: " + e.getMessage());
		    }
		return false;
	}
	
	
	//======================================
	// READ
	//======================================	
	public String getRoleName (int roleId) {
		String sql = String.format("Select * from %s WHERE id = ?", this.TABLENAME3);
		
		 try (Connection connection = DatabaseUtil.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(sql)) {
	            
	            stmt.setInt(1, roleId);
	            ResultSet rs = stmt.executeQuery();
	            
	            if (rs.next()) {
	                String name = rs.getString("name");
	                return name;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		 return null;
	}
	
	public ArrayList<Role> getRoleList () {
		String sql = String.format("SELECT * FROM %s", this.TABLENAME3);
		ArrayList<Role> roleNames = new ArrayList<>();
		 try (Connection connection = DatabaseUtil.getConnection();
	             PreparedStatement stmt = connection.prepareStatement(sql)) {
	         
	            ResultSet rs = stmt.executeQuery();
	            
	            while (rs.next()) {
	            	int id = rs.getInt("id");
	                String name = rs.getString("name");
	                roleNames.add(new Role(id,name));
	                
	            }
	            return roleNames;
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
		 return null;
	}
	
	public void getMemberById(int id, HttpSession session, int actorId) {
        String sql = String.format("SELECT * FROM %s WHERE id = ?", this.tableName);
        
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String name = rs.getString("name");
                int role_id = rs.getInt("role_id");
                Member member = new Member(id, name, role_id);
                setSession(session, member, actorId);
                List<Service> cart = new ArrayList<>();
                session.setAttribute("cart", cart);

            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	public MemberInfo getMemberDetail(int id) {
	    String sql = String.format("SELECT m.id AS member_id, m.name, m.role_id, m.email, m.phone, " +
	                               "a.id AS address_id, a.address " +
	                               "FROM %s m LEFT JOIN %s a ON m.id = a.member_id WHERE m.id = ?", 
	                               this.tableName, TABLENAME2);

	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        stmt.setInt(1, id);
	        ResultSet rs = stmt.executeQuery();

	        MemberInfo member = null;
	        ArrayList<Address> addresses = new ArrayList<>();

	        while (rs.next()) {
	            if (member == null) {
	                // Initialize member info on the first result
	                String name = rs.getString("name");
	                int roleId = rs.getInt("role_id");
	                String email = rs.getString("email");
	                String phone = rs.getString("phone");
	                member = new MemberInfo(id, name, roleId, email, phone, addresses);
	            }

	            // Add address if available
	            int addressId = rs.getInt("address_id");
	            String addressStr = rs.getString("address");
	            if (addressStr != null) {
	                addresses.add(new Address(addressId, addressStr));
	            }
	        }

	        return member;

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	
	public ArrayList<MemberInfo> getAllMemberDetails (boolean isAdmin) {
		ArrayList<MemberInfo> members = new ArrayList<MemberInfo>();
		String sql = String.format("SELECT * FROM %s", this.tableName);
		
		  try (Connection connection = DatabaseUtil.getConnection();
		             PreparedStatement stmt = connection.prepareStatement(sql)) {
		       
		            ResultSet rs = stmt.executeQuery();
		            
		            while (rs.next()) {
		            	int id = rs.getInt("id");
		                String name = rs.getString("name");
		                int role_id = rs.getInt("role_id");
		                String email = rs.getString("email");
		                String phone = rs.getString("phone");
		                ArrayList<Address> address = new ArrayList<Address>();
		                //==================================================================================
		                // Second sql to get the address list
		                //==================================================================================
		                String sql2 = String.format("Select * from %s WHERE member_id = ?", TABLENAME2);
		                try (Connection connection2 = DatabaseUtil.getConnection();
		                        PreparedStatement stmt2 = connection2.prepareStatement(sql2)) {
			                       stmt2.setInt(1, id);
			                       ResultSet rs2 = stmt2.executeQuery();
			                       
			                       System.out.println(rs2);
			                       
			                       while (rs2.next()) {
			                    	   int addressid = rs2.getInt("id");
			                    	   String addressStr = rs2.getString("address");
			                          address.add(new Address(addressid,addressStr));
			                       }   
			            } catch (SQLException e) {
			              	   e.printStackTrace();
			            }  
		                
		                MemberInfo member = new MemberInfo (id, name, role_id, email, phone, address);
		                members.add(member);
		               
		            }
		            return members;
		            
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		  return null;
	}

	public boolean loginMember(String email, String password, HttpSession session) {
	    String sql = String.format("SELECT * FROM %s WHERE email = ? AND password = ?", this.tableName);

	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {
	         
	        stmt.setString(1, email);
	        stmt.setString(2, hashPassword(password));

	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                // Retrieve member details
	                int id = rs.getInt("id");
	                getMemberById(id, session, id);
	                return true;
	            }
	        }

	    } catch (SQLException e) {
	        System.err.println("Error while logging in: " + e.getMessage());
	    }
	    return false;
	}

	//======================================
	// UPDATE 
	//======================================
	public boolean updateMemberName(int id, String name, int actorId, HttpSession session) {
	    String sql = String.format("UPDATE %s SET name = ? WHERE id = ?", this.tableName);
	    
	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        // Set parameters
	        stmt.setString(1, name);
	        stmt.setInt(2, id);
	 
	        
	        // Execute update
	        int rowsAffected = stmt.executeUpdate();
	        if (rowsAffected > 0) {
	            // If update is successful, fetch the updated member details
	        	getMemberById(id, session, actorId);
	        	return true;
	        }
	    } catch (SQLException e) {
	        System.err.println("Error while updating member name: " + e.getMessage());
	    }
	    return false;
	}
	
	public boolean updateMemberPhone(int id, String phone) {
	    String sql = String.format("UPDATE %s SET phone = ? WHERE id = ?", this.tableName);
	    
	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        // Set parameters
	        stmt.setString(1, phone);
	        stmt.setInt(2, id);

	        // Execute update
	        int rowsAffected = stmt.executeUpdate();
	       return rowsAffected > 0;
	    } catch (SQLException e) {
	        System.err.println("Error while updating member phone: " + e.getMessage());
		     return false;
	    }
	}
	
	public boolean updateMemberAddress (int id, String address) {
		 String sql = String.format("UPDATE %s SET address = ? WHERE id = ?", this.TABLENAME2);
		    
		    try (Connection connection = DatabaseUtil.getConnection();
		         PreparedStatement stmt = connection.prepareStatement(sql)) {

		        // Set parameters
		        
		        stmt.setString(1, address);
		        stmt.setInt(2, id);

		        // Execute update
		        int rowsAffected = stmt.executeUpdate();
		       return rowsAffected > 0;
		    } catch (SQLException e) {
		        System.err.println("Error while updating member address: " + e.getMessage());
			     return false;
		    }
	}
	// Only admin can update the role 
	public boolean updateMemberRole(int id, int newRole, int actorId, HttpSession session) {
	    String sql = String.format("UPDATE %s SET role_id = ? WHERE id = ?", this.tableName);
	    
	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        // Set parameters
	        stmt.setInt(1, newRole);
	        stmt.setInt(2, id);

	        // Execute update
	        int rowsAffected = stmt.executeUpdate();
	        if( rowsAffected > 0) {
	        	getMemberById(id, session, actorId);
	        	return true;
	        }; 
	    } catch (SQLException e) {
	        System.err.println("Error while updating member phone: " + e.getMessage());
	    
	    }
	    return false;
	}
	
	// Admin cannot edit the user email and password
	public boolean updateMemberEmail(int id, String email, int actorId) {
	    String sql = String.format("UPDATE %s SET email = ? WHERE id = ? AND id = ? ", this.tableName);
	    
	    try (Connection connection = DatabaseUtil.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	        // Set parameters
	        stmt.setString(1, email); 
	        stmt.setInt(2, id);      
	        stmt.setInt(3, actorId);   

	        // Execute update
	        int rowsAffected = stmt.executeUpdate();
	        return rowsAffected > 0; 

	    } catch (SQLException e) {
	        System.err.println("Error while updating member email: " + e.getMessage());
	        return false;
	    }
	}
	// Admin cannot edit the user email and password
	public boolean updateMemberPassword (int id, String hashedNewPassword, String hashedOldPassword) {
		 String sql = String.format("UPDATE %s SET password = ? WHERE password = ? AND id = ?", this.tableName);
		    
		    try (Connection connection = DatabaseUtil.getConnection();
		         PreparedStatement stmt = connection.prepareStatement(sql)) {

		        // Set parameters
		        stmt.setString(1, hashedNewPassword); 
		        stmt.setString(2, hashedOldPassword);
		        stmt.setInt(3, id);      
		        // Execute update
		        int rowsAffected = stmt.executeUpdate();
		        return rowsAffected > 0; 

		    } catch (SQLException e) {
		        System.err.println("Error while updating member password: " + e.getMessage());
		        return false;
		    }
	}

	
	//======================================
	// DELETE
	//======================================
	public boolean deleteMember(int id, boolean isAdmin) {
	    String sql = String.format("DELETE from %s WHERE id = ?", this.tableName);
	    if (isAdmin) {
	    	try (Connection connection = DatabaseUtil.getConnection();
	   	         PreparedStatement stmt = connection.prepareStatement(sql)) {

	   	        // Set parameters
	   	        stmt.setInt(1, id);

	   	        // Execute update
	   	        int rowsAffected = stmt.executeUpdate();
	   	        return rowsAffected > 0; 
	   	    } catch (SQLException e) {
	   	        System.err.println("Error while updating member phone: " + e.getMessage());
	   	        return false;
	   	    }
	    } else return false;
	    
	}
	
	public boolean deleteMemberAddress (int addressId) {
		 String sql = String.format("DELETE FROM %s WHERE id = ? ", this.TABLENAME2);

		    try (Connection connection = DatabaseUtil.getConnection();
		         PreparedStatement stmt = connection.prepareStatement(sql)) {

		        stmt.setInt(1, addressId);

		        int rowsAffected = stmt.executeUpdate();

		        // Check if a row was inserted
		        if (rowsAffected > 0) {
		            return true;
		        }

		    } catch (SQLException e) {
		        System.err.println("Error while creating member: " + e.getMessage());
		    }
		return false;
	}
	
}
