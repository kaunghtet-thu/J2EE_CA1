<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	/* ================================
	Author: Kaung Htet Thu (P2340768)
	Class: dit/2a/23
	Description: ST0510 Pract2 - part 3
	================================= */
	
	String message = request.getParameter("errCode");
	if(message != null && message.equals("invalidLogin")) {
		out.print("<h1> Please try again!</h1>");
	}
%>
	<form action="verifyUser.jsp" method="post">
	    <label for="loginid">Login ID:</label>
	    <input type="text" id="loginid" name="loginid"><br><br>
	    
	    <label for="password">Password:</label>
	    <input type="password" id="password" name="password"><br><br>
	    
	    <input type="submit" name="btnSubmit" value="Login">
	    <input type="reset" value="Reset">
	</form>
</body>
</html>