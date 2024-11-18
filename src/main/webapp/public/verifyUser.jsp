<%@page import ="java.sql.*"%>
<%@page import ="DAO.MemberDAO" %>
<%@page import ="model.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify User</title>
</head>
<body>


<%


String email = request.getParameter("email");
String password = request.getParameter("password");
Member member;

MemberDAO dao = new MemberDAO();
member = dao.loginMember(email, password);
	if (member != null) {
		session.setAttribute("member", member);
		response.sendRedirect("index.jsp");
	} else {
		response.sendRedirect("login.jsp?errCode=invalidLogin");
	}
%>
</body>
</html>
