<%@page import ="java.sql.*"%>
<%@page import ="DAO.MemberDAO" %>
<%@page import ="bean.Member" %>
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


MemberDAO dao = new MemberDAO();
//dao.loginMember(email, password, session);
	if (dao.loginMember(email, password, session)) {
		response.sendRedirect("index.jsp");
	} else {
		response.sendRedirect("login.jsp?errCode=invalidLogin");
	}
%>
</body>
</html>
