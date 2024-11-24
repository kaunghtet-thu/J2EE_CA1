package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import DB.DatabaseUtil;

/**
 * Servlet implementation class AddNewServiceCategory
 */
@WebServlet("/public/AddNewServiceCategory")
public class AddNewServiceCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewServiceCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
        String newCat = request.getParameter("serviceCategory");
        
        if (newCat == null || newCat.trim().isEmpty()) {
            response.sendRedirect("index.jsp?errorCode=invalidInput");
            return;
        }

        String sql = "INSERT INTO category (name) VALUES (?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Set the parameter in the prepared statement
            stmt.setString(1, newCat.trim());

            int result = stmt.executeUpdate();
            if (result > 0) {
             
                response.sendRedirect("services.jsp?successMsg=Added_Successfully");
            } else {
                // Redirect on failure
                response.sendRedirect("services.jsp?errorMsg=Add_Error");
            }
        } catch (SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the category.");
        }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
