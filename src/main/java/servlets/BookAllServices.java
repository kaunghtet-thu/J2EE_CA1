package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DAO.BookingDAO;
import DAO.MemberDAO;

import DAO.BookingServiceDAO;
import bean.BookingService;
import bean.Service;
import bean.Address;

@WebServlet("/BookAllServices")
public class BookAllServices extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int memberId = (int)session.getAttribute("memberId");
        MemberDAO memberDAO = new MemberDAO();

        // Get the common address, date, and time if selected
        Integer commonAddressId = null;
        String commonAddress = null;
        if (request.getParameter("commonAddress") != null && !request.getParameter("commonAddress").isEmpty()) {
            commonAddressId = Integer.parseInt(request.getParameter("commonAddress"));
            if (commonAddressId == -1) {
                commonAddress = request.getParameter("newCommonAddress");
            } else {
                Address commonAddressObj = memberDAO.getAddressById(commonAddressId);
                commonAddress = commonAddressObj.getAddress();
            }
        }
        String commonDate = request.getParameter("commonDate");
        String commonTime = request.getParameter("commonTime");

        // Get the selected services from the session
        List<Service> cart = (List<Service>) session.getAttribute("cart");

        // Process the form data
        List<Map<String, Object>> bookingDetails = new ArrayList<>();
        List<BookingService> bookingServices = new ArrayList<>();
        for (Service service : cart) {
            int serviceId = service.getId();

            // Get the address, date, and time for the current service
            String addressParam = "address_" + serviceId;
            String dateParam = "serviceDate_" + serviceId;
            String timeParam = "serviceTime_" + serviceId;

            Integer addressId = null;
            String address = null;
            String date = null;
            String time = null;

            // Check if the user selected a different address, date, or time for the current service
            boolean differentAddresses = request.getParameter("differentAddresses") != null;
            boolean differentDates = request.getParameter("differentDates") != null;
            boolean differentTimes = request.getParameter("differentTimes") != null;

            if (differentAddresses) {
                if (request.getParameter(addressParam) != null && !request.getParameter(addressParam).isEmpty()) {
                    addressId = Integer.parseInt(request.getParameter(addressParam));
                    if (addressId == -1) {
                        address = request.getParameter("newAddress_" + serviceId);
                    } else {
                        Address selectedAddress = memberDAO.getAddressById(addressId);
                        address = selectedAddress.getAddress();
                    }
                } else {
                    address = null;
                }
            } else {
                addressId = commonAddressId;
                address = commonAddress;
            }

            if (differentDates) {
                date = request.getParameter(dateParam);
            } else {
                date = commonDate;
            }

            if (differentTimes) {
                time = request.getParameter(timeParam);
            } else {
                time = commonTime;
            }

            // Process the booking and save the data
            BookingService bookingService = new BookingService();
            bookingService.setServiceId(serviceId);
            bookingService.setQuantity(1);
            bookingService.setAddressId(addressId);
            bookingService.setBookingDate(LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            bookingService.setBookingTime(LocalTime.parse(time, DateTimeFormatter.ofPattern("HH:mm")));
            bookingServices.add(bookingService);

            Map<String, Object> bookingInfo = new HashMap<>();
            bookingInfo.put("serviceId", serviceId);
            bookingInfo.put("address", address);
            bookingInfo.put("date", date);
            bookingInfo.put("time", time);
            bookingDetails.add(bookingInfo);
        }

        // Create the booking
        BookingDAO bookingDAO = new BookingDAO();
        int bookingId = bookingDAO.createBooking(memberId, 1);

        if (bookingId == -1) {
            request.setAttribute("errorMessage", "Booking failed. Please try again.");
            request.getRequestDispatcher("/public/cart.jsp").forward(request, response);
            return;
        }

        // Create the booking services
        BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
        boolean success = bookingServiceDAO.createBookingServices(bookingId, bookingServices);

//        if (success) {
//            // Pass the booking details to the JSP
//            request.setAttribute("bookingDetails", bookingDetails);
        if (success) {
            // Print the booking details
            System.out.println("Booking Details:");
            for (Map<String, Object> booking : bookingDetails) {
                System.out.println("Service ID: " + booking.get("serviceId"));
                System.out.println("Address: " + booking.get("address"));
                System.out.println("Date: " + booking.get("date"));
                System.out.println("Time: " + booking.get("time"));
                System.out.println("---");
            }
            response.sendRedirect(request.getContextPath() + "/public/cart.jsp?successMsg=Yayyy!");
        } else {
            request.setAttribute("errorMessage", "Booking failed. Please try again.");
            request.getRequestDispatcher("/public/cart.jsp").forward(request, response);
        }
    }
}
