<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Members</title>
<style>

	.table-container {
        width: 100%;
        overflow-x: auto;
        padding: 10px;
    }

    table {
        width: 100%;
        table-layout: fixed; /* Ensures table columns don't stretch beyond the container */
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        border: 1px solid #ddd;
        word-wrap: break-word; /* Break long words into multiple lines */
    }

    th {
        background-color: #f4f4f4;
    }

    /* Optional: Add a max-width to make sure it doesn’t stretch too wide */
    .table-container table {
        max-width: 90%;
    }

    .actions {
        white-space: nowrap; /* Prevents buttons from breaking into multiple lines */
    }
</style>
</head>
<body>
<%@include file="header.jsp" %>

<%
  MemberDAO dao = new MemberDAO();
	ArrayList<MemberInfo> members = dao.getAllMemberDetails(isAdmin);
	//ArrayList<Role> roleNames = dao.getRoleList();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String idParam = request.getParameter("id");
        int hiddenid = (idParam != null) ? Integer.parseInt(idParam) : 0;
        String action = request.getParameter("action");

        boolean updateSuccess = false;
        String updateMessage = "";

        // Check if the action is delete
        if (action != null && action.equals("delete")) {

			if (!isAdmin) {
				updateMessage = "Not authorized to delete member";
			}
            updateSuccess = dao.deleteMember(hiddenid, isAdmin);
            updateMessage = updateSuccess ? "Member deleted successfully!" : "Failed to delete member.";
        }
        out.print(updateMessage);
        members = dao.getAllMemberDetails(isAdmin);
    }
%>

<div>
	<p><%=members.size() %> total members found</p>
</div>
<div class="table-container">
 <table border="1" style="width:100%; border-collapse:collapse;">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Role</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Addresses</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <% 
        if (members != null && !members.isEmpty()) {
            for (MemberInfo eachMember : members) { 
        %>
        <tr>
            <td><%= eachMember.getId() %></td>
            <td><%= eachMember.getName() %></td>
            <td><%= dao.getRoleName(eachMember.getRole())%></td>
            <td><%= eachMember.getEmail() %></td>
            <td><%= eachMember.getPhone() %></td>
            <td>
                <% 
                ArrayList<Address> addresses = eachMember.getAddress();
                if (addresses != null && !addresses.isEmpty()) {
                    for (Address address : addresses) { 
                %>
                <div>
                    <%= address.getAddress() %> 
                </div>
                <% 
                    }
                } else { 
                %>
                <div><i>No Address Saved</i></div>
                <% } %>
            </td>
            <td>
			    <form method="post" action="profile.jsp">
			        <input type="hidden" name="id" value="<%= eachMember.getId() %>">
			        <button type="submit" name="action" value="manage">Manage</button>
			    </form>
			    <form method="post">
			        <input type="hidden" name="id" value="<%= eachMember.getId() %>">
			        <button type="submit" name="action" value="delete">Delete</button>
			    </form>
			</td>
        </tr>
        <% 
            }
        } else { 
        %>
        <tr>
            <td colspan="6">No members found.</td>
        </tr>
        <% } %>
    </tbody>
</table>
</div>
<%@include file="footer.html" %>
</body>
</html>