<%@page import="DAO.*" %>
<%@page import="bean.*" %>
<%@page import="java.util.*" %>
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
int categoryId = Integer.parseInt(request.getParameter("categoryId"));
ServiceDAO dao = new ServiceDAO();
List<Service> services = dao.getServicesByCategory(categoryId);
session.setAttribute("services", services);
response.sendRedirect("services.jsp");

%>
</body>
</html>