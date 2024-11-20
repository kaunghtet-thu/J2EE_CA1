<%@page import="DAO.ServiceCategoryDAO"%>
<%@page import="bean.ServiceCategory"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Service Categories</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            display: flex;
            justify-content: center;
            padding-top: 50px;
        }
        h1 {
            color: #333;
        }
        .category-table {
            width: 80%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .category-table th, .category-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .category-table th {
            background-color: #4CAF50;
            color: #fff;
            font-weight: bold;
        }
        .category-table tr:hover {
            background-color: #f1f1f1;
        }
        .center {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="center">
        <h1>All Service Categories</h1>
        <!-- Form to handle the clicked row submission -->
<form action="showServicesByCategory.jsp" method="post">
    <table class="category-table" border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                ServiceCategoryDAO dao = new ServiceCategoryDAO();
                List<ServiceCategory> allCategories = dao.getAllServiceCategories();
                
                if (!allCategories.isEmpty()) {
                    for (ServiceCategory category : allCategories) {
            %>
            <tr>
                <!-- Hidden input to send categoryId -->
                <td><%= category.getId() %></td>
                <td><%= category.getName() %></td>
                <td>
                    <!-- Submit button for each category -->
                    <button type="submit" name="categoryId" value="<%= category.getId() %>">Select</button>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3" style="text-align: center;">No Service Categories Found</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</form>

    </div>
</body>
</html>
