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

import DAO.BookingDAO;
import bean.Booking;
import bean.Member;

/**
 * Servlet implementation class BookService
 */
@WebServlet("/BookService")
public class BookService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookService() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		HttpSession session = request.getSession();
		
		Member member = (Member) session.getAttribute("member");
		int serviceId = (int)session.getAttribute("serviceId");
		LocalDate bookingDate = LocalDate.parse(request.getParameter("serviceDate"));
        LocalTime bookingTime = LocalTime.parse(request.getParameter("serviceTime"));
        // Get the current session
		BookingDAO dao = new BookingDAO();
		boolean success = dao.addBooking(new Booking(member.getId(), serviceId, 1, null, bookingDate, bookingTime, LocalDateTime.now()));
        	
		if(success)
			response.sendRedirect("public/booking.jsp?successMsg=Booked successfully!");
		else
			response.sendRedirect("public/booking.jsp?errormsg=Booked failed.");
			
		
	}

}
