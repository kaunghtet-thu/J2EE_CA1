package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import DAO.BookingDAO;
import DAO.BookingServiceDAO;
import bean.BookingService;
import bean.Service;

@WebServlet("/BookAllServices")
public class BookAllServices extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the services from the session storage (cart)
        HttpSession session = request.getSession();
        List<Service> services = (List<Service>) session.getAttribute("cart");

        if (services == null || services.isEmpty()) {
            // Redirect to the cart page or display an error message
            response.sendRedirect("public/cart.jsp");
            return;
        }

        // Retrieve the member ID and address ID from the request parameters
        int memberId = (int) session.getAttribute("memberId");
        int commonAddressId = Integer.parseInt(request.getParameter("commonAddress"));
        String newCommonAddress = request.getParameter("newCommonAddress");

        // Retrieve the date and time inputs
        boolean useDifferentAddresses = Boolean.parseBoolean(request.getParameter("differentAddresses"));
        boolean useDifferentDates = Boolean.parseBoolean(request.getParameter("differentDates"));
        boolean useDifferentTimes = Boolean.parseBoolean(request.getParameter("differentTimes"));

        // Parse the common date and time using custom formatters
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate commonDate = LocalDate.parse(request.getParameter("commonDate"), dateFormatter);

        LocalTime commonTime = LocalTime.parse(request.getParameter("commonTime"));

        List<BookingService> bookingServices = new ArrayList<>();
        for (Service service : services) {
            BookingService bookingService = new BookingService();
            bookingService.setServiceId(service.getId());
            bookingService.setQuantity(1); // Assuming 1 for now, you can add a quantity field in the JSP

            if (useDifferentAddresses) {
                int addressId = Integer.parseInt(request.getParameter("address_" + service.getId()));
                String newAddress = request.getParameter("newAddress_" + service.getId());
                bookingService.setAddressId(addressId);
            } else {
                bookingService.setAddressId(commonAddressId);
            }

            if (useDifferentDates) {
                bookingService.setBookingDate(LocalDate.parse(request.getParameter("serviceDate_" + service.getId()), dateFormatter));
            } else {
                bookingService.setBookingDate(commonDate);
            }

            if (useDifferentTimes) {
                bookingService.setBookingTime(LocalTime.parse(request.getParameter("serviceTime_" + service.getId())));
            } else {
                bookingService.setBookingTime(commonTime);
            }

            bookingServices.add(bookingService);
        }

        // Create a new booking
        BookingDAO bookingDAO = new BookingDAO();
        int bookingId = bookingDAO.createBooking(memberId, 1);

        if (bookingId == -1) {
            // Handle the error, e.g., redirect to an error page
            response.sendRedirect("error.jsp");
            return;
        }

        // Add the booking services to the database
        BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
        boolean success = bookingServiceDAO.createBookingServices(bookingId, bookingServices);

        if (success) {
            // Booking and booking services created successfully
            // You can redirect the user to a confirmation page or perform any other necessary actions
            response.sendRedirect("public/cart.jsp?successMsg=Services have been booked successfully!");
        } else {
            // Handle the error, e.g., redirect to an error page
            response.sendRedirect("public/cart.jsp?errorMsg=Booking failed!");
        }
    }
}