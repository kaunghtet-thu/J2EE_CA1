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
    max-width: 600px;
    margin: auto;
    padding: 15px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    background-color: #f9f9f9;
}

h1 {
    text-align: center;
    color: #333;
}

.form-group {
    margin-bottom: 20px;
    position: relative;
}

.label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
    color: #555;
}

.input-wrapper {
    display: flex;
    align-items: center;
    border: 2px solid #ddd;
    border-radius: 5px;
    padding: 5px;
    background-color: #fff;
}

.input-wrapper input[type="text"] {
    flex: 1;
    border: none;
    outline: none;
    padding: 8px;
    font-size: 14px;
}

.input-wrapper button {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 8px 12px;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 5px;
    transition: background-color 0.3s ease;
}

.input-wrapper button:hover {
    background-color: #0056b3;
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
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

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
                default:
                    updateMessage = "Invalid field specified.";
            }
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
    <div class="form-group">
        <form method="post" class="edit-form">
            <label for="name">Name</label>
            <div class="input-wrapper">
                <input type="hidden" name="field" value="name">
                <input type="text" id="name" name="value" value="<%= memberInfo.getName() %>" required>
                <button type="submit">Update</button>
            </div>
        </form>
    </div>

    <!-- Email -->
    <div class="form-group">
        <form method="post" class="edit-form">
            <label for="email">Email</label>
            <div class="input-wrapper">
                <input type="hidden" name="field" value="email">
                <input type="text" id="email" name="value" value="<%= memberInfo.getEmail() %>" required>
                <% if (isMember || (isAdmin && id == member.getId())) { %>
                    <button type="submit">Update</button>
                <% } %>
            </div>
        </form>
    </div>

    <!-- Phone -->
    <div class="form-group">
        <form method="post" class="edit-form">
            <label for="phone">Phone</label>
            <div class="input-wrapper">
                <input type="hidden" name="field" value="phone">
                <input type="text" id="phone" name="value" value="<%= memberInfo.getPhone() %>" required>
                <button type="submit">Update</button>
            </div>
        </form>
    </div>

    <!-- Address -->
    <div class="form-group">
        <label>Address</label>
        <% 
            List<Address> addresses = memberInfo.getAddress();
            for (Address address : addresses) { 
        %>
            <form method="post" class="edit-form">
                <div class="input-wrapper">
                    <input type="hidden" name="field" value="address">
                    <input type="hidden" name="addressId" value="<%= address.getId() %>">
                    <input type="text" name="value" value="<%= address.getAddress() %>" required>
                    <button type="submit">Update</button>
                </div>
            </form>
        <% } %>
    </div>
</div>

<%@ include file="footer.html" %>
</body>
</html>
