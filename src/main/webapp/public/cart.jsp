<%@ page import="java.util.List" %>
<%@ page import="bean.Service" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
</head>
<body>
<%@include file="header.jsp" %>

    <h1>Your Cart</h1>
    
    <%
        // Retrieve the cart from the session
        List<Service> cart = (List<Service>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Your cart is empty.</p>
    <%
        } else {
    %>
        <table border="1">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Service service : cart) {
                %>
                <tr>
                    <td><%= service.getName() %></td>
                    <td><%= service.getDescription() %></td>
                    <td><%= service.getPrice() %></td>
                    <td>
                        <!-- Delete Form -->
                        <form action="RemoveFromCart" method="POST" style="display:inline;">
                            <input type="hidden" name="serviceId" value="<%= service.getId() %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <p>Total Items: <%= cart.size() %></p>
    <%
        }
    %>
	<form action="showServicesByCategory.jsp" method="get">
	    <button type="submit">Continue Shopping</button>
	</form>
    <%@include file="footer.html" %>
    
</body>
</html>
