package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.*;
import DAO.Invoicing;
import bean.Booking;

@WebServlet("/public/generateReceipt")
public class InvoicingServlet extends HttpServlet {

    private Invoicing bookingReceiptService = new Invoicing();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Extract booking details from the request (you can use actual form data here)
            Booking booking = new Booking(
                    12345,                      // id
                    67890,                      // memberId
                    98765,                      // serviceId
                    1,                          // statusId (e.g., 1 for "Confirmed")
                    1122,                       // staffId (e.g., ID of the assigned staff member)
                    LocalDate.of(2025, 1, 27),  // bookingDate
                    LocalTime.of(14, 0),        // bookingTime (2:00 PM)
                    LocalDateTime.of(2025, 1, 25, 10, 30) // bookedAt (e.g., 25th Jan 2025 at 10:30 AM)
            );

            // Generate the PDF receipt (now as byte array)
            byte[] pdfBytes = bookingReceiptService.generatePdfReceipt(booking);

            // Send the email with the PDF attachment
            String recipientEmail = "kaunghsetaung8@gmail.com";
            String subject = "Your Booking Receipt";
            String body = "Thank you for your booking. Please find your receipt attached..\\n\\n\" +\r\n"
            		+ "\"Best regards,\\n\" +\r\n"
            		+ "\"Spotless Cleaning Services Team\\n\"";
            bookingReceiptService.sendEmailWithAttachment(recipientEmail, subject, body, pdfBytes);

            // Respond to the client
            response.getWriter().write("Receipt generated and emailed successfully!");
        } catch (Exception e) {
            // Handle exceptions (e.g., log and send error response)
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred: " + e.getMessage());
        }
    }
}
