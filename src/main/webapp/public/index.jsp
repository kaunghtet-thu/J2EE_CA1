<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.ServiceCategory" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SPOTLESS</title>
</head>
<body>
<%@ include file="header.html" %>
<h1>Welcome from SPOTLESS</h1>
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
</p>

<h2>Services available</h2>
<%

	ArrayList<ServiceCategory> categories = new ArrayList<>();
	
%>
<%@ include file="footer.html" %>
</body>
</html>