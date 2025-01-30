package DAO;

import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import bean.Invoice;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.activation.DataHandler;
import jakarta.mail.util.ByteArrayDataSource;

import java.io.*;
import java.util.Properties;

public class Invoicing {

    // Method to generate PDF receipt for a single invoice and return it as byte array
    public byte[] generatePdfReceipt(Invoice invoice) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        // Create a PDF writer linked to the byte array output stream
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdfDocument = new PdfDocument(writer);
        Document document = new Document(pdfDocument);

        // Add heading
        document.add(new Paragraph("INVOICE").setFontSize(20));
        document.add(new Paragraph("SPOTLESS CLEANING SERVICES").setFontSize(18));
        document.add(new Paragraph("Booking Receipt").setFontSize(14));
        document.add(new Paragraph("\n"));

        // Add booking details
        document.add(new Paragraph("Booking ID: " + invoice.getBookingid()));
        document.add(new Paragraph("Customer Name: " + invoice.getCustomerName()));
        document.add(new Paragraph("Booked At: " + invoice.getBookedAt().toString()));
        document.add(new Paragraph("\n"));

        // Create a table for service details
     // Create a table with 4 columns
        Table serviceTable = new Table(new float[] { 4, 4, 4, 2 })  // Define column widths directly
                .useAllAvailableWidth();

        serviceTable.addCell("Service Taken");
        serviceTable.addCell("Service Date");
        serviceTable.addCell("Time slot");
        serviceTable.addCell("Price");

        serviceTable.addCell(invoice.getServiceTaken());  // Service Taken
        serviceTable.addCell(invoice.getBookingDate().toString());  // Booked Date
        serviceTable.addCell(invoice.getBookingTime().toString());  // Booked Time
        serviceTable.addCell("$" + String.format("%.2f", invoice.getPrice()));  // Price


        serviceTable.setFontSize(12);

        document.add(serviceTable);

        document.add(new Paragraph("\n"));

        double gstAmount = invoice.getPrice() * 0.09; 
        document.add(new Paragraph("GST 9%: $" + String.format("%.2f", gstAmount)).setFontSize(12));
        document.add(new Paragraph("Original Price: $" + String.format("%.2f", invoice.getPrice())).setFontSize(12));
        
        double grandTotal = invoice.getPrice() + gstAmount;  
        document.add(new Paragraph("Grand Total: $" + String.format("%.2f", grandTotal)).setFontSize(14));


        // Add auto-generated invoice disclaimer
        document.add(new Paragraph("\n"));
        document.add(new Paragraph("This is an auto-generated invoice, no need for signature.").setFontSize(10));

        // Close the document (flushes the content to the byte array)
        document.close();

        return baos.toByteArray();
    }

    // Method to send email with PDF attachment
    public void sendEmailWithAttachment(String recipientEmail, String subject, String body, byte[] pdfBytes) throws MessagingException {
        // Set up email properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Set up the session
        Session session = Session.getInstance(properties, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("spotlesscleaningservices.jad@gmail.com", "bnrd xzmf fwob pcrn"); 
            }
        });

        // Create the email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("spotlesscleaningservices.jad@gmail.com"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject(subject);

        // Create a MimeBodyPart to hold the email body
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText(body);  // Set the body text here

        // Create a MimeBodyPart to hold the PDF attachment
        MimeBodyPart attachmentPart = new MimeBodyPart();
        ByteArrayDataSource source = new ByteArrayDataSource(pdfBytes, "application/pdf");
        attachmentPart.setDataHandler(new DataHandler(source));
        attachmentPart.setFileName("receipt_" + System.currentTimeMillis() + ".pdf");

        // Create a multipart message and add both the body text and the attachment
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);  // Add the body part
        multipart.addBodyPart(attachmentPart);  // Add the attachment part
        message.setContent(multipart);  // Set the content of the message

        // Send the email
        Transport.send(message);
    }
}
