<%@page import="java.sql.*" %>
<%@page import="model.ServiceCategory" %>
<%@page import="DAO.ServiceCategoryDAO" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%
    // Database connection
    String url = "jdbc:postgresql://ep-empty-snow-a1bh28k1.ap-southeast-1.aws.neon.tech/cleaning_service?user=neondb_owner&password=bvf53wyBEJrk&sslmode=require";
    
    Connection connection = null;
    List<ServiceCategory> categories = new ArrayList<>();

    try {
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(url);
        
        // Fetch categories
        ServiceCategoryDAO serviceCategoryDAO = new ServiceCategoryDAO(connection);
        categories = serviceCategoryDAO.getAllServiceCategories();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Service Categories</title>
</head>
<body>
    <h1>Service Categories</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
        </tr>
        <%
            for (ServiceCategory category : categories) {
        %>
            <tr>
                <td><%= category.getId() %></td>
                <td><%= category.getName() %></td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>
