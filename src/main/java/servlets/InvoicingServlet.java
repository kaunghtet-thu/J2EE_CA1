package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.*;

import DAO.Invoicing;
import bean.Invoice;

@WebServlet("/public/generateReceipt")
public class InvoicingServlet extends HttpServlet {

    private Invoicing bookingReceiptService = new Invoicing();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Create a single invoice with sample data
            Invoice invoice = new Invoice(1, "John Doe", LocalDateTime.of(2025, 1, 25, 14, 30), "Cleaning Service",
                    LocalDate.of(2025, 1, 25), LocalTime.of(14, 30), 99.99);

            // Generate the PDF receipt for the single invoice (now as byte array)
            byte[] pdfBytes = bookingReceiptService.generatePdfReceipt(invoice);

            // Send the email with the PDF attachment
            String recipientEmail = "kaunghsetaung8@gmail.com";
            String subject = "Your Booking Receipt";
            String body = "Thank you for your booking. Please find your receipt attached.\n\n" +
                    "Best regards,\n" +
                    "Spotless Cleaning Services Team\n";
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
