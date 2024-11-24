<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="DAO.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Members</title>
</head>
<body>
<%@include file="header.jsp" %>

<%
  MemberDAO dao = new MemberDAO();
	ArrayList<MemberInfo> members = dao.getAllMemberDetails(isAdmin);
	out.print(members.size());
	
	

 %>
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
            <td><%= eachMember.getRole() %></td>
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
			    <form method="post" action="MemberController">
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
  
<%@include file="footer.html" %>
</body>
</html>