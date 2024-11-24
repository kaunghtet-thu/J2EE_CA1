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
<%@include file="header.jsp" %>

<%
    String errorMessage = (String) request.getParameter("errorMsg");
    if (errorMessage != null) {
%>
    <p style="color: red;"><%= errorMessage %></p>
<%
    }

    // Declare categoryId outside the try block for wider scope
    Integer categoryId = null;

    try {
        String categoryIdParam = request.getParameter("categoryId");

        if (categoryIdParam != null) {
            categoryId = Integer.parseInt(categoryIdParam);
            session.setAttribute("categoryId", categoryId);
        } else if (session.getAttribute("categoryId") != null) {
            categoryId = (Integer) session.getAttribute("categoryId");
        }
    } catch (NumberFormatException e) {
        out.println("<p style='color: red;'>Invalid category ID format. Please try again.</p>");
    }

    // If categoryId is valid, fetch and display services
    if (categoryId != null) {
        ServiceDAO dao = new ServiceDAO();
        List<Service> servicesList = dao.getServicesByCategory(categoryId);

        if (servicesList == null || servicesList.isEmpty()) {
%>
            <p>No services found for the selected category.</p>
<%
        } else {
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
                for (Service service : servicesList) {
%>
                    <tr>
                        <td><%= service.getName() %></td>
                        <td><%= service.getDescription() %></td>
                        <td><%= service.getPrice() %></td>
                        <td><img src="images/cleaning.png" alt="<%= service.getName() %>" width="100" height="100"></td>
                        <td>
                            <form action="AddToCart" method="POST" style="display:inline;">
                                <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
                                <input type="submit" value="Add To Cart" />
                            </form>

                            <form action="bookAService.jsp" method="POST" style="display:inline;">
                                <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
                                <input type="hidden" name="serviceName" value="<%= service.getName() %>" />
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
        }
    } else {
%>
    <p>No category is selected.</p>
<%
    }
%>

<%@include file="footer.html" %>


</body>
</html>
