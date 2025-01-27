package DAO;
import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.element.Paragraph;

import bean.Booking;

import com.itextpdf.layout.Document;
import jakarta.mail.*;
import jakarta.mail.util.*;
import jakarta.mail.internet.*;
import jakarta.activation.DataHandler;

import java.io.*;
import java.util.Properties;

public class Invoicing {

    // Method to generate PDF receipt and return it as byte array
    public byte[] generatePdfReceipt(Booking booking) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        // Create a PDF writer linked to the byte array output stream
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdfDocument = new PdfDocument(writer);
        Document document = new Document(pdfDocument);

        // Add content to the PDF
        document.add(new Paragraph("SPOTLESS CLEANING SERVICES"));
        document.add(new Paragraph("Booking Receipt"));
        document.add(new Paragraph("Booking ID: " + booking.getId()));
        document.add(new Paragraph("Member ID: " + booking.getMemberId()));
        document.add(new Paragraph("Service ID: " + booking.getServiceId()));
        document.add(new Paragraph("Booking Date: " + booking.getBookingDate()));
        document.add(new Paragraph("Booking Time: " + booking.getBookingTime()));
        document.add(new Paragraph("Cleaning Hours: " + booking.getCleaningHour()));

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