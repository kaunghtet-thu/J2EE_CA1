<%@page import="bean.*" %><%@page import="DAO.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/style.css">
    
    <title>SPOTLESS Cleaning Services</title>
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
        <li><a href="services.jsp">Services</a></li>
        <% if (isMember){
        %>	       
        <li><a href="cart.jsp">Cart</a></li>
         <li><a href="bookings.jsp">Booking History</a></li>
        <% } %>
        <% if (isAdmin){
        %>	
        <li><a href="displayAllMembers.jsp">Members</a></li>
        <li><a href="feedback.jsp">Feedback History</a></li>
        <% } %>
      
    </ul>
</nav>

</body>
</html>
