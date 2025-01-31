package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import DB.DatabaseUtil;

@WebServlet("/public/AddNewServiceCategory")
public class AddNewServiceCategory extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddNewServiceCategory() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not allowed for this operation.");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the category name
        String newCategoryName = request.getParameter("serviceCategory");
        System.out.println(newCategoryName + "This is new cat name");
        // Get the uploaded image file
        Part imagePart = request.getPart("categoryImage");

        // Check if the image part is null
        
 
        if (imagePart == null) {
            response.sendRedirect("services.jsp?errorMsg=No image file uploaded.");
            return;
        }
        
 

        String imageFileName = imagePart.getSubmittedFileName();

        // Validate inputs
        if (newCategoryName == null || newCategoryName.trim().isEmpty() || imageFileName == null || imageFileName.trim().isEmpty()) {
            response.sendRedirect("services.jsp?errorMsg=Invalid input. Please fill in all fields.");
            return;
        }

        // Define the directory to save the image (e.g., in the "images" folder)
        String uploadDir = getServletContext().getRealPath("/images");
        File uploadDirPath = new File(uploadDir);
        if (!uploadDirPath.exists()) {
            uploadDirPath.mkdirs();  // Create the directory if it doesn't exist
        }

        // Generate a unique filename for the image to avoid overwriting
        String uniqueImageName = System.currentTimeMillis() + "_" + imageFileName;
        File imageFile = new File(uploadDirPath, uniqueImageName);

        // Save the uploaded image to the server
        imagePart.write(imageFile.getAbsolutePath());

        // Insert the category into the database
        String sql = "INSERT INTO category (name, image) VALUES (?, ?)";
        try (Connection connection = DatabaseUtil.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Set the parameters for the prepared statement
            stmt.setString(1, newCategoryName.trim());
            stmt.setString(2, uniqueImageName);

            int result = stmt.executeUpdate();
            if (result > 0) {
                response.sendRedirect("services.jsp?successMsg=Category added successfully.");
            } else {
                response.sendRedirect("services.jsp?errorMsg=Error adding category.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the category.");
        }
    }

}
