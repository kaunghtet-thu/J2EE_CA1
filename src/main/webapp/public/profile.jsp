<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="DAO.MemberDAO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
		    max-width: 35vw;
		    margin: auto;
		    padding: 15px;
		}
		
		h1 {
		    text-align: center;
		    color: #333;
		}

        .message {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 4px;
        }

        .message.success {
            color: green;
            background-color: #e7f9e7;
            border: 1px solid green;
        }

        .message.error {
            color: red;
            background-color: #fdecea;
            border: 1px solid red;
        }
        
        fieldset {
        	margin-bottom: 10px;
        	background-color:  #E3EED4;
        }
        button {
        	background-color:  #c5d1ba;
        }
        input::placeholder {
		    font-style: italic;
		}
		        
    </style>
</head>
<body>
<%@ include file = "header.jsp" %>

<%
    MemberDAO dao = new MemberDAO();
    int id = request.getParameter("memberId") != null ? Integer.parseInt(request.getParameter("memberId")) : ((Member)session.getAttribute("member")).getId();
    int actorId = member.getId();
    out.println("id of member" + id);
	out.println("id of actor" + actorId);
    MemberInfo memberInfo = dao.getMemberDetail(id);

    boolean updateSuccess = false;
    String updateMessage = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	String idParam = request.getParameter("id");
    	int hiddenid = idParam != null ? Integer.parseInt(idParam) : 0;
        String field = request.getParameter("field");
        String value = request.getParameter("value");

        if (field != null && value != null) {
            switch (field) {
                case "name":
                	out.print("id of member" + hiddenid);
                	out.print("id of actor" + actorId);
                    updateSuccess = dao.updateMemberName(hiddenid, value, actorId, session);
                    updateMessage = updateSuccess ? "Name updated successfully!" : "Failed to update name.";
                    break;
                case "email":
                	out.print("id of member" + hiddenid);
                	out.print("id of actor" + actorId);
                    updateSuccess = dao.updateMemberEmail(hiddenid, value, actorId);
                    updateMessage = updateSuccess ? "Email updated successfully!" : "Failed to update email.";
                    break;
                case "phone":
                	out.print("id of member" + hiddenid);
                	out.print("id of actor" + actorId);
                    updateSuccess = dao.updateMemberPhone(hiddenid, value);
                    updateMessage = updateSuccess ? "Phone updated successfully!" : "Failed to update phone.";
                    break;
                case "newAddress":
                	updateSuccess = dao.addMemberAddress(hiddenid, value);
                	updateMessage = updateSuccess ? "Address added successfully!" : "Failed to add address.";
                    break;
                default:
                    updateMessage = "Invalid field specified.";
            }
        }
        memberInfo = dao.getMemberDetail(hiddenid);
        dao.getMemberById(id, session,actorId);
    }
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	String idParam = request.getParameter("id");
    	int hiddenid = idParam != null ? Integer.parseInt(idParam) : 0;
        String field = request.getParameter("field");
 

        if (field != null && field.equals("address")) {
            int index = 0;  // Index to track each address
            while (true) {
                String addressIdParam = "addressId_" + index;
                String valueParam = "value_" + index;

                String value = request.getParameter(valueParam);
                if (value == null) break;  // Exit loop when no more address updates are found

                int addressId = Integer.parseInt(request.getParameter(addressIdParam));

                // Check if it's an update or delete action
                String deleteAddress = request.getParameter("deleteAddress");
                if (deleteAddress != null && Integer.parseInt(deleteAddress) == addressId) {
                    // Handle the deletion
                    updateSuccess = dao.deleteMemberAddress(addressId);
                    updateMessage = updateSuccess ? "Address deleted successfully!" : "Failed to delete address.";
                } else {
                    // Handle the update
                    updateSuccess = dao.updateMemberAddress(addressId, value);
                    updateMessage = updateSuccess ? "Address updated successfully!" : "Failed to update address " + (index + 1) + ".";
                }

                index++;  // Move to the next address
            }
        }
        memberInfo = dao.getMemberDetail(hiddenid); // Refresh data after update or delete
    }
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
    	String idParam = request.getParameter("id");
    	int hiddenid = idParam != null ? Integer.parseInt(idParam) : 0;
        String field = request.getParameter("field");

        if (field != null && field.equals("password")) {
            // Retrieve the password fields from the request
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmNewPassword = request.getParameter("confirmNewPassword");

            updateSuccess = false;
            updateMessage = "";

            if (newPassword != null && confirmNewPassword != null && newPassword.equals(confirmNewPassword)) {
                int memberId = id;
                    updateSuccess = dao.updateMemberPassword(hiddenid, newPassword, oldPassword);
                    updateMessage = updateSuccess ? "Password updated successfully!" : "Failed to update password.";
                    if (!updateSuccess) {
                    	updateMessage = "Password update failed";
                    }
              
            } else {
                updateMessage = "New password and confirmation password do not match.";
            }

  
        }

         memberInfo = dao.getMemberDetail(hiddenid); 
    }

%>

<div class="container">
    <h1>User Profile</h1>

    <% if (updateMessage != null) { %>
        <div class="message <%= updateSuccess ? "success" : "error" %>">
            <strong><%= updateMessage %></strong>
        </div>
    <% } %>

    <fieldset>
        <legend>Name:</legend>
        <form method="post" class="edit-form">
        	<input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="field" value="name">
            <input type="text" id="name" name="value" value="<%= memberInfo.getName() %>" required>
            <button type="submit">Update</button>
        </form>
    </fieldset>

    <fieldset>
        <legend>Email:</legend>
        <form method="post" class="edit-form">
        	<input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="field" value="email">
            <input type="text" id="email" name="value" value="<%= memberInfo.getEmail() %>" required>
            <% if (isMember || (isAdmin && id == member.getId())) { %>
                <button type="submit">Update</button>
            <% } %>
        </form>
    </fieldset>

    <fieldset>
        <legend>Phone:</legend>
        <form method="post" class="edit-form">
        	<input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="field" value="phone">
            <input type="text" id="phone" name="value" value="<%= memberInfo.getPhone() %>" required>
            <button type="submit">Update</button>
        </form>
    </fieldset>

   <fieldset>
	    <legend>Address:</legend>
	    <form method="post" class="edit-form">
	    	<input type="hidden" name="id" value="<%= id %>">
	        <% 
	            List<Address> addresses = memberInfo.getAddress();
	        int index = 0;
	        	if (addresses.size() > 0) {
	             
	            for (Address address : addresses) { 
	        %>
	            <input type="hidden" name="field" value="address">
	            <input type="hidden" name="addressId_<%= index %>" value="<%= address.getId() %>">
	            <%= index+1%> .<input type="text" name="value_<%= index %>" value="<%= address.getAddress() %>" required>
	            
	            <button type="submit" name="updateAddress" value="<%= index %>">Update</button>
	            <button type="submit" name="deleteAddress" value="<%= address.getId() %>">Delete</button>
	            <br>
	        <% 
	            index++;  // Increment index for unique field names
	            }  }
	        	else {
	        %>
	        	<p>You have no saved addresses yet</p>
	        	<% } %>
	    </form>
	
	    <form method="post" class="edit-form">
	        <input type="hidden" name="field" value="newAddress">
	        <input type="hidden" name="id" value="<%= id %>">
	        <%=index+1 %> .<input type="text" id="newAddress" name="value" placeholder="Add a new address" required>
	        <button type="submit">Add</button>
	    </form>
	</fieldset>
	
	<fieldset>
	    <legend>Reset Password</legend>
	    <form method="post" class="edit-form">
	        <input type="hidden" name="field" value="password">
	        <input type="hidden" name="id" value="<%= id %>">
	        <input type="password" id="oldPassword" name="oldPassword" placeholder="Enter old password" required><br>
	        <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password"required><br>
	        <input type="password" id="confirmNewPassword" name="confirmNewPassword" placeholder="Confirm new password" required><br>
	        <button type="submit">Update</button>
	    </form>
	</fieldset>

</div>

</body>
</html>
