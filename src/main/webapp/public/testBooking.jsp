<%@ page import="java.time.LocalDate, java.time.LocalTime, java.time.LocalDateTime" %>
<%@ page import="java.util.*, DAO.BookingDAO, model.Booking" %>

<%
    // Initialize DAO
    BookingDAO bookingDAO = new BookingDAO();

    // Handle form actions
    String action = request.getParameter("action");
    if ("create".equals(action)) {
        try {
            int memberId = Integer.parseInt(request.getParameter("member_id"));
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
    List<Booking> bookings = bookingDAO.getAllBookings();
%>

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
            <form action="testBooking.jsp" method="post" style="display:inline;">
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

<!-- Create Booking Form -->
<form action="testBooking.jsp" method="post">
    <input type="hidden" name="action" value="create">
    <input type="number" name="member_id" placeholder="Member ID" required>
    <input type="number" name="service_id" placeholder="Service ID" required>
    <input type="number" name="status_id" placeholder="Status ID" required>
    <input type="date" name="booking_date" required>
    <input type="time" name="booking_time" required>
    <button type="submit">Create Booking</button>
</form>

<!-- Update Booking Form -->
<form action="testBooking.jsp" method="post">
    <input type="hidden" name="action" value="update">
    <input type="number" name="id" placeholder="Booking ID" required>
    <input type="number" name="status_id" placeholder="New Status ID" required>
    <button type="submit">Update Booking</button>
</form>
