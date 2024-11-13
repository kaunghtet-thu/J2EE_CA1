<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dev_kai branch push test</title>
</head>
<body>
<%@page import ="java.sql.*"%>

<%
	/* ================================
	Author: Kaung Htet Thu (P2340768)
	Class: dit/2a/23
	Description: ST0510 Pract2 - part 4
	================================= */
	
	String user = request.getParameter("loginid");
	String pwd = request.getParameter("password");
	String userRole = "adminUser";
	
	try {
        // Step 1: Load JDBC Driver
        Class.forName("org.postgresql.Driver");

        // Step 2: Define Connection URL
        String connURL = "jdbc:postgresql://ep-empty-snow-a1bh28k1.ap-southeast-1.aws.neon.tech/cleaning_service?user=neondb_owner&password=bvf53wyBEJrk&sslmode=require";

        // Step 3: Establish connection to URL
        Connection conn = DriverManager.getConnection(connURL); 
        
        // Step 4: Create Statement object
        Statement stmt = conn.createStatement();

        // Step 5: Execute SQL Command
        String sqlStr = "SELECT * FROM role";         
        ResultSet rs = stmt.executeQuery(sqlStr);

        // Step 6: Process Result
        while (rs.next()) { 
            String id = rs.getString("id");
            String name = rs.getString("name");
  %>          
            <p>Role ID: <%= id %>, Role Name: <%= name %></p>
<% 
        }
        // Step 7: Close connection
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }
	
	
	
%>	
</body>
</html>