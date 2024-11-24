<%@page import="bean.*" %><%@page import="DAO.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SPOTLESS Cleaning Services</title>
    <style>
        /* Header styling */
        header {
            background-color: #E3EED4;
            color: black;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        body {
        	margin: 0; /* Remove default margin */
            padding-bottom: 50px; /* Ensure content doesn't overlap footer */
        }
        .header-title {
            font-size: 32px;
            margin: 0;
            font-weight: bold;
            letter-spacing: 1px;
            font-variant: small-caps;
        }
        .profile-icon {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .profile-icon i {
            font-size: 30px;
            color: black;
            cursor: pointer;
        }
        .iconText {
            text-decoration: none;
            color: black;
            font-size: 16px;
            font-weight: bold;
        }
        .iconText:hover {
            color: #007bff;
        }
        .login-button, .logout-button, .profile-button {
            font-size: 14px;
            padding: 5px 10px;
            border: 1px solid grey;
            background-color: #c5d1ba;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }
        .login-button:hover, .logout-button:hover, .profile-button:hover {
            background-color: #4cae4c;
            color: white;
        }
        a {
        	text-decoration: none;
        	color: #000;
        	margin-right:3px;
        }
        nav {
            display: flex;
            background-color: #c5d1ba;
            padding: 10px 0;
            margin-top: 0;
            position: sticky;
            top: 0;
        }
        nav ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
        }
        nav ul li {
            margin: 0 15px;
        }
        nav ul li a {
            text-decoration: none;
            color: black;
            font-size: 16px;
            font-weight: bold;
            transition: color 0.3s;
        }
        nav ul li a:hover {
            color: #007bff;
        }
       
    </style>
</head>
<body>
<%@include file="checkUser.jsp" %>


<header>
    <div class="header-title">
    	 <% if (isMember || isAdmin || isStaff) { %>
        <i>WELCOME</i> <%=member.getName().toUpperCase() %>
        <%} else { %>
        <i>SPOTLESS</i> Cleaning Services
        <%} %>
    </div>
    <div class="profile-icon">
        <% if (isMember || isAdmin || isStaff) { %>
            <a href="profile.jsp" class="profile-button">Profile</a><br>
            <button class ="logout-button" onclick="location.href='logout.jsp'">Log out</button>
        <% } else { %>
            <button class="login-button" onclick="location.href='login.jsp'">Log in</button>
        <% } %>
    </div> 
</header>


<nav>
    <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="index.jsp">Services</a></li>
        <% if (isMember){
        %>	
       
        <li><a href="cart.jsp">Cart</a></li>
        <li><a href="showMemberBookings.jsp">Booking History</a></li>
        <% } %>
        <% if (isAdmin){
        %>	
       
        <li><a href="#">Manage Service</a></li>
        <li><a href="displayAllMembers.jsp">Members</a></li>
        <li><a href="#">Feedback History</a></li>
        
        <% } %>
    </ul>
</nav>

</body>
</html>
