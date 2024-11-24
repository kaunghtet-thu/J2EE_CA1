<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cleaning Service Booking</title>
<!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Flatpickr CSS -->
  <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">
</head>
<body>
<%@include file="header.jsp" %>

<%
try {
    String serviceId = request.getParameter("serviceId");
    int id;

    if (serviceId != null) {
        id = Integer.parseInt(serviceId);
        session.setAttribute("serviceId", id);
    } else if (session.getAttribute("categoryId") != null) {
        id = (Integer) session.getAttribute("serviceId");
    }
} catch (NumberFormatException e) {
    out.println("<p style='color: red;'>Invalid service ID format. Please try again.</p>");
}

    String errorMessage = (String) request.getParameter("errorMsg");
    String successMessage = (String) request.getParameter("successMsg");
    if (errorMessage != null) {
%>
    <p style="color: red;"><%= errorMessage %></p>
<%
    }
    if (successMessage != null) {
%>
    <p style="color: green;"><%= successMessage %></p>
<%
    }
	String name = request.getParameter("serviceName");
	if(name != null)
		session.setAttribute("serviceName", name);
	else
		name = (String)session.getAttribute("serviceName");
%>
	<h2> You have chosen <%=name %>.</h2>
	<form action="BookService" method="POST">
      <!-- Calendar Date Picker -->
      <div class="mb-3">
        <label for="serviceDate" class="form-label">Preferred Date</label>
        <input 
          type="text" 
          id="serviceDate" 
          class="form-control" 
          name="serviceDate" 
          placeholder="Select a date" 
          required>
      </div>
      
      <!-- Time Input -->
      <div class="mb-3">
        <label for="serviceTime" class="form-label">Preferred Time</label>
        <input 
          type="time" 
          class="form-control" 
          id="serviceTime" 
          name="serviceTime" 
          required>
      </div>
      
      <!-- Submit Button -->
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Flatpickr JS -->
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <script>
    // Initialize Flatpickr
    flatpickr("#serviceDate", {
      dateFormat: "Y-m-d", // Customize format
      minDate: "today",    // Disable past dates
      defaultDate: "today" // Pre-select today's date
    });
  </script>
  <button 
      class="btn btn-primary" 
      onclick="window.location.href='<%= request.getContextPath() %>/public/showMemberBookings.jsp';">
     	See your bookings
    </button>
    <%@include file="footer.html" %>
    
</body>
</html>



