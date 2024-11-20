<%@ page import="java.util.List" %>
<%@ page import="model.Service" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
</head>
<body>
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
    
    <a href="showAllServiceCategories.jsp">Continue Shopping</a>
</body>
</html>
