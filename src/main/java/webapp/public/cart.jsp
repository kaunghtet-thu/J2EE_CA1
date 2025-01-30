<%@ page import="java.util.List" %>
<%@ page import="bean.Service" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="successError.jsp" %>

    <h1>Your Cart</h1>
    
    <%
        // Retrieve the cart from the session
        List<Service> cart = (List<Service>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p class="succMsg">Your cart is empty.</p>
    <%
        } else {
    %>
        <table border="1">
            <thead>
                <tr>
                    <th width="300">Name</th>
                    <th width="600">Description</th>
                    <th width="80">Price</th>
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
                        <%
                        if(isPublic) {
                        %>
                        
                        <form action="login.jsp" method="POST" style="display:inline;">
                            <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
                            <input type="hidden" name="serviceName" value="<%= service.getName() %>" />
                            <input type="submit" value="Book" />
                        </form>
                        <%	
                        } else {
                        %>
                        <form action="bookAService.jsp" method="POST" style="display:inline;">
                            <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
                            <input type="hidden" name="serviceName" value="<%= service.getName() %>" />
					                <input type="hidden" name="servicePrice" value="<%= service.getPrice() %>" />
                            <input type="submit" value="Book" />
                        </form>
                        <% }
                        %>
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
	<form action="services.jsp" method="get">
	    <button type="submit">Continue Shopping</button>
	</form>
	<form action="BookAllServicesInCart.jsp" method="get">
	    <button type="submit">Book All</button>
	</form>
    <%@include file="footer.html" %>
    
</body>
</html>
