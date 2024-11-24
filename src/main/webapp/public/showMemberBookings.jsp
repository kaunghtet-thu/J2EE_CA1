<%@ page import="bean.Booking, bean.Feedback, DAO.FeedbackDAO, DAO.StatusDAO, DAO.ServiceDAO, DAO.BookingDAO" %>
<%@ page import="java.util.List" %>

<%@ include file="header.jsp" %>

<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
    <p><%= message %></p>
<%
        session.removeAttribute("message");
    }

    FeedbackDAO feedbackDAO = new FeedbackDAO();
    StatusDAO statusDAO = new StatusDAO();
    ServiceDAO serviceDAO = new ServiceDAO();
    BookingDAO bookingDAO = new BookingDAO();

    List<Booking> bookings = bookingDAO.getBookingsByMemberId((int)session.getAttribute("memberId"));
%>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Service</th>
        <th>Status</th>
        <th>Booking Date</th>
        <th>Booking Time</th>
        <th>Booked At</th>
        <th>Feedback</th>
        <th>Actions</th>
    </tr>
    <%
        for (Booking booking : bookings) {
            Feedback feedback = feedbackDAO.getFeedbackByBookingId(booking.getId());
            String statusName = statusDAO.getStatusName(booking.getStatusId());
    %>
    <tr>
        <td><%= booking.getId() %></td>
        <td><%= serviceDAO.getServiceById(booking.getServiceId()).getName() %></td>
        <td><%= statusName %></td>
        <td><%= booking.getBookingDate() %></td>
        <td><%= booking.getBookingTime() %></td>
        <td><%= booking.getBookedAt() %></td>
        <td>
            <%
                if (feedback != null) {
            %>
                <strong>Rating:</strong> <%= feedback.getRating() %><br>
                <strong>Comments:</strong> <%= feedback.getComments() %>
            <%
                } else if("Completed".equals(statusName)){
                    out.print("No Feedback Yet");
                } 
            %>
        </td>
        <td>
        <%
        	if (feedback != null) {
        %>
            <form action="ManageBooking" method="post" style="display:inline;">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="edit_id" value="<%= booking.getId() %>">
                <button type="submit">Edit</button>
            </form>
            <form action="ManageBooking" method="post" style="display:inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="delete_id" value="<%= booking.getId() %>">
                <button type="submit">Delete</button>
            </form>
            <%
        	} else {
                if ("Completed".equals(statusName)) {
            %>
                <form action="ManageBooking" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="feedback">
                    <input type="hidden" name="feedback_id" value="<%= booking.getId() %>">
                    <button type="submit">Give Feedback</button>
                </form>
            <%
                }}
            %>
        </td>
    </tr>
    <%
        }
    %>
</table>

<%
    if (request.getAttribute("feedbackId") != null) {
        int feedbackId = (int) request.getAttribute("feedbackId");
        Feedback existingFeedback = feedbackDAO.getFeedbackByBookingId(feedbackId);
%>
    <form action="ManageBooking" method="post">
        <input type="hidden" name="action" value="submitFeedback">
        <input type="hidden" name="booking_id" value="<%= feedbackId %>">
        <label for="rating">Rating (1-5):</label>
        <input type="number" name="rating" id="rating" min="1" max="5" required value="<%= existingFeedback != null ? existingFeedback.getRating() : "" %>">
        <label for="comments">Comments:</label>
        <textarea name="comments" id="comments" rows="3" required><%= existingFeedback != null ? existingFeedback.getComments() : "" %></textarea>
        <button type="submit">Submit Feedback</button>
    </form>
<%
    }
%>
<%
    if (request.getAttribute("editId") != null) {
        int feedbackId = (int) request.getAttribute("editId");
        Feedback existingFeedback = feedbackDAO.getFeedbackByBookingId(feedbackId);
%>
    <form action="ManageBooking" method="post">
        <input type="hidden" name="action" value="editFeedback">
        <input type="hidden" name="booking_id" value="<%= feedbackId %>">
        <label for="rating">Rating (1-5):</label>
        <input type="number" name="rating" id="rating" min="1" max="5" required value="<%= existingFeedback != null ? existingFeedback.getRating() : "" %>">
        <label for="comments">Comments:</label>
        <textarea name="comments" id="comments" rows="3" required><%= existingFeedback != null ? existingFeedback.getComments() : "" %></textarea>
        <button type="submit">Submit Feedback</button>
    </form>
<%
    }
%>
