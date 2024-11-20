<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="bean.Service" %>
<%@ page import="DAO.ServiceDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services Under Category</title>
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
    <p style="color: red;"><%= errorMessage %></p>
<%
    }
%>


<%
    // Retrieve the categoryId passed from the form submission
    String categoryIdParam = request.getParameter("categoryId");

    if (categoryIdParam != null) {
        // Parse categoryId from the request
        int categoryId = Integer.parseInt(categoryIdParam);

        // Output the selected category ID for confirmation
        out.println("<h2>Category ID: " + categoryId + " was selected!</h2>");

        // Use ServicesDAO to get services under the selected category
        ServiceDAO dao = new ServiceDAO();
        List<Service> servicesList = dao.getServicesByCategory(categoryId);

        // Display the services in a table if any services are found
        if (servicesList != null && !servicesList.isEmpty()) {
%>
            <h3>Services under Category ID: <%= categoryId %></h3>
            <table border="1">
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
      
            // Loop through the services list and display each service
            for (Service service : servicesList) {
        %>
        <tr>
            <td><%= service.getName() %></td>
            <td><%= service.getDescription() %></td>
            <td><%= service.getPrice() %></td>
            <td><img src="images/cleaning.png" alt="<%= service.getName() %>" width="100" height="100"></td>
            <td>
                <!-- Add to Cart Form -->
                <form action="AddToCart" method="POST" style="display:inline;">
                    <input type="hidden" name="serviceId" value="<%=service.getId()%>"/>
                    <input type="submit" value="Add To Cart" />
                </form>

                <!-- Book Service Form -->
                <form action="BookService" method="POST" style="display:inline;">
                    <input type="hidden" name="serviceId" value="<%=service.getId()%>"/>
                    <input type="submit" value="Book" />
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

        
            
<%
        } else {
            out.println("<h3>No services found under this category.</h3>");
        }
    } else {
        out.println("<h3>No category selected!</h3>");
    }
%>

</body>
</html>
