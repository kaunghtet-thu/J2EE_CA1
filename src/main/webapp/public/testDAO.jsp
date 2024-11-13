<%@page import="DAO.ServiceCategoryDAO"%>
<%@page import="model.ServiceCategory"%>
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
        <table class="category-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
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
                    <td><%= category.getId() %></td>
                    <td><%= category.getName() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="2" style="text-align: center;">No Service Categories Found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
