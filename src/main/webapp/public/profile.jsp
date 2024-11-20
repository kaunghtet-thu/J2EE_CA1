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
		    max-width: 30vw;
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
    </style>
</head>
<body>
<%@ include file = "header.jsp" %>

<%
    MemberDAO dao = new MemberDAO();
    int id = request.getParameter("memberId") != null ? Integer.parseInt(request.getParameter("memberId")) : member.getId();
    int actorId = member.getId();
    MemberInfo memberInfo = dao.getMemberDetail(id);

    boolean updateSuccess = false;
    String updateMessage = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String field = request.getParameter("field");
        String value = request.getParameter("value");

        if (field != null && value != null) {
            switch (field) {
                case "name":
                    updateSuccess = dao.updateMemberName(id, value, actorId, session);
                    updateMessage = updateSuccess ? "Name updated successfully!" : "Failed to update name.";
                    break;
                case "email":
                    updateSuccess = dao.updateMemberEmail(id, value, actorId);
                    updateMessage = updateSuccess ? "Email updated successfully!" : "Failed to update email.";
                    break;
                case "phone":
                    updateSuccess = dao.updateMemberPhone(id, value, actorId);
                    updateMessage = updateSuccess ? "Phone updated successfully!" : "Failed to update phone.";
                    break;
                case "address":
                    int addressId = Integer.parseInt(request.getParameter("addressId"));
                    updateSuccess = dao.updateMemberAddress(addressId, value);
                    updateMessage = updateSuccess ? "Address updated successfully!" : "Failed to update address.";
                    break;
                case "newAddress":
                    String newAddress = request.getParameter("newAddress");
                    if (newAddress != null && !newAddress.isEmpty()) {
                        updateSuccess = dao.addMemberAddress(id, newAddress);
                        updateMessage = updateSuccess ? "New address added successfully!" : "Failed to add new address.";
                    } else {
                        updateMessage = "Address cannot be empty.";
                    }
                    break;
                default:
                    updateMessage = "Invalid field specified.";
            }
        }

        if ("true".equals(request.getParameter("showNewField"))) {
            
        } else {
            
        }

        memberInfo = dao.getMemberDetail(id); // Refresh data after update
    }
%>

<div class="container">
    <h1>User Profile</h1>

    <% if (updateMessage != null) { %>
        <div class="message <%= updateSuccess ? "success" : "error" %>">
            <strong><%= updateMessage %></strong>
        </div>
    <% } %>

    <!-- Name -->
    <fieldset>
        <legend>Name:</legend>
        <form method="post" class="edit-form">
            <input type="hidden" name="field" value="name">
            <input type="text" id="name" name="value" value="<%= memberInfo.getName() %>" required>
            <button type="submit">Update</button>
        </form>
    </fieldset>

    <!-- Email -->
    <fieldset>
        <legend>Email:</legend>
        <form method="post" class="edit-form">
            <input type="hidden" name="field" value="email">
            <input type="text" id="email" name="value" value="<%= memberInfo.getEmail() %>" required>
            <% if (isMember || (isAdmin && id == member.getId())) { %>
                <button type="submit">Update</button>
            <% } %>
        </form>
    </fieldset>

    <!-- Phone -->
    <fieldset>
        <legend>Phone:</legend>
        <form method="post" class="edit-form">
            <input type="hidden" name="field" value="phone">
            <input type="text" id="phone" name="value" value="<%= memberInfo.getPhone() %>" required>
            <button type="submit">Update</button>
        </form>
    </fieldset>

    <!-- Address -->
    <fieldset>
        <legend>Address:</legend>
        <form method="post" action="<%= request.getContextPath() %>/user-profile">
            <% 
                // Render existing addresses
                List<Address> addresses = memberInfo.getAddress();
                for (Address address : addresses) { 
            %>
                <input type="hidden" name="field" value="address">
                <input type="hidden" name="addressId" value="<%= address.getId() %>">
                <input type="text" name="value" value="<%= address.getAddress() %>" required>
                <button type="submit" name="updateAddress" value="<%= address.getId() %>">Update</button>
                <br>
            <% 
                }  
                
            %>
              <input type="hidden" name="field" value="newAddress">
              <input type="text" name="newAddress" placeholder="Enter new address" required>
            <button type="submit">Add</button>
         
        </form>
    </fieldset>

</div>

</body>
</html>
