package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import model.Service;
import DAO.ServiceDAO;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/public/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCart() {
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
		doGet(request, response);
		
		String serviceId = request.getParameter("serviceId");
		int id = Integer.parseInt(serviceId);
	
	    // Retrieve the service object using the serviceId (you may need to fetch it from a database or service list)
	    ServiceDAO dao = new ServiceDAO();
	    Service service = dao.getServiceById(id); // Implement this method to get the service
        PrintWriter out = response.getWriter();

	
	    if (service == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid service ID");
            return;
        }

        // Get the current session
        HttpSession session = request.getSession();

        // Retrieve the cart from the session, or create a new one if it doesn't exist
        List<Service> cart = (List<Service>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Check if the service is already in the cart
        boolean alreadyInCart = cart.stream().anyMatch(item -> item.getId() == service.getId());
        if (alreadyInCart) {
            // Redirect with a message if the item is already in the cart
            out.print("<br>This item is already in your cart.");
            return;
        }

        // Add the service to the cart
        cart.add(service);

        // Redirect to a success or cart page
        response.sendRedirect("cart.jsp");
	}

}
