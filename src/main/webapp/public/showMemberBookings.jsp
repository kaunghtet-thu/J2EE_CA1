<%@ page import="java.time.LocalDate, java.time.LocalTime, java.time.LocalDateTime" %>
<%@ page import="java.util.*, DAO.BookingDAO,bean.Booking" %>
	<%@include file="header.jsp" %>

<%
    // Initialize DAO
    BookingDAO bookingDAO = new BookingDAO();
	//Member member = (Member)session.getAttribute("member");
	int memberId = member.getId();

    // Handle form actions
    String action = request.getParameter("action");
    if ("create".equals(action)) {
        try {
            int serviceId = Integer.parseInt(request.getParameter("service_id"));
            int statusId = Integer.parseInt(request.getParameter("status_id"));
            LocalDate bookingDate = LocalDate.parse(request.getParameter("booking_date"));
            LocalTime bookingTime = LocalTime.parse(request.getParameter("booking_time"));
            LocalDateTime bookedAt = LocalDateTime.now();

            boolean created = bookingDAO.addBooking(new Booking(memberId, serviceId, statusId, null, bookingDate, bookingTime, bookedAt));
            out.println("<p>" + (created ? "Booking created successfully!" : "Failed to create booking.") + "</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else if ("update".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int statusId = Integer.parseInt(request.getParameter("status_id"));

            boolean updated = bookingDAO.updateBookingStatus(id, statusId);
            out.println("<p>" + (updated ? "Booking updated successfully!" : "Failed to update booking.") + "</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    } else if ("delete".equals(action)) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            boolean deleted = bookingDAO.deleteBooking(id);
            out.println("<p>" + (deleted ? "Booking deleted successfully!" : "Failed to delete booking.") + "</p>");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }

    // Fetch all bookings
    List<Booking> bookings = bookingDAO.getBookingsByMemberId(memberId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking</title>
<style>
	/* General Page Style */
	body {
	    font-family: 'Arial', sans-serif;
	    background-color: #f4f7fc;
	    margin: 0;
	    padding: 0;
	}
	
	/* Header */
	h1 {
	    text-align: center;
	    padding: 20px 0;
	    background-color: #4CAF50;
	    color: white;
	}
	
	/* Table Style */
	table {
	    width: 80%;
	    margin: 20px auto;
	    border-collapse: collapse;
	    background-color: white;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	
	table, th, td {
	    border: 1px solid #ddd;
	}
	
	th, td {
	    padding: 10px;
	    text-align: center;
	}
	
	th {
	    background-color: #4CAF50;
	    color: white;
	}
	
	/* Form Style */
	form {
	    width: 60%;
	    margin: 20px auto;
	    background-color: white;
	    padding: 20px;
	    border-radius: 8px;
	    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	}
	
	form input[type="number"],
	form input[type="date"],
	form input[type="time"],
	form button {
	    width: 100%;
	    padding: 12px;
	    margin: 8px 0;
	    font-size: 16px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	}
	
	form input[type="number"]:focus,
	form input[type="date"]:focus,
	form input[type="time"]:focus {
	    border-color: #4CAF50;
	    outline: none;
	}
	
	/* Button Style */
	button {
	    background-color: #4CAF50;
	    color: white;
	    font-size: 16px;
	    border: none;
	    cursor: pointer;
	    border-radius: 4px;
	    padding: 10px 20px;
	}
	
	button:hover {
	    background-color: #45a049;
	}
	
	/* Action Buttons (Delete) */
	form button[type="submit"] {
	    background-color: #f44336;
	}
	
	form button[type="submit"]:hover {
	    background-color: #e53935;
	}
	
	/* Text and Information */
	p {
	    text-align: center;
	    font-size: 18px;
	    margin: 10px 0;
	}
	
	h2 {
	    text-align: center;
	    color: #333;
	}
	
	/* Input and Select Field Style */
	input, select {
	    font-size: 16px;
	}
	
	/* Mobile Responsiveness */
	@media (max-width: 768px) {
	    table {
	        width: 100%;
	    }
	    form {
	        width: 90%;
	    }
	}
		
</style>
</head>
<body>
	<!-- Booking Table -->
	<table border="1">
	    <tr>
	        <th>ID</th>
	        <th>Member ID</th>
	        <th>Service ID</th>
	        <th>Status ID</th>
	        <th>Staff ID</th>
	        <th>Booking Date</th>
	        <th>Booking Time</th>
	        <th>Booked At</th>
	        <th>Actions</th>
	    </tr>
	    <%
	        for (Booking booking : bookings) {
	    %>
	    <tr>
	        <td><%= booking.getId() %></td>
	        <td><%= booking.getMemberId() %></td>
	        <td><%= booking.getServiceId() %></td>
	        <td><%= booking.getStatusId() %></td>
	        <td><%= booking.getStaffId() %></td>
	        <td><%= booking.getBookingDate() %></td>
	        <td><%= booking.getBookingTime() %></td>
	        <td><%= booking.getBookedAt() %></td>
	        <td>
	            <!-- Delete -->
	            <form action="showMemberBookings.jsp" method="post" style="display:inline;">
	                <input type="hidden" name="action" value="delete">
	                <input type="hidden" name="id" value="<%= booking.getId() %>">
	                <button type="submit">Delete</button>
	            </form>
	        </td>
	    </tr>
	    <%
	        }
	    %>
	</table>
	
	<!-- Update Booking Form -->
	<form action="memberBooking.jsp" method="post">
	    <input type="hidden" name="action" value="update">
	    <input type="number" name="id" placeholder="Booking ID" required>
	    <input type="number" name="status_id" placeholder="New Status ID" required>
	    <button type="submit">Update Booking</button>
	</form>
	<%@include file="footer.html" %>
	
</body>
</html>