<%@page import="DAO.ServiceCategoryDAO"%>
<%@page import="bean.ServiceCategory"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Service Categories</title>
    <style>
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
	<%@include file="header.jsp" %>

<div class="center">
    <h1>All Service Categories</h1>
    <%

        ServiceCategoryDAO dao = new ServiceCategoryDAO();
        List<ServiceCategory> allCategories = dao.getAllServiceCategories();
        
        if (!allCategories.isEmpty()) {
    %>
    <!-- Display categories in a stylish list -->
    <div class="category-list">
        <%
            for (ServiceCategory category : allCategories) {
        %>
        <!-- Each category item -->
        <form action="showServicesByCategory.jsp" method="post" class="category-item">
            <!-- Hidden input to send categoryId -->
            <input type="hidden" name="categoryId" value="<%= category.getId() %>">
            <!-- Clickable category name -->
            <button type="submit" class="category-link">
                <%= category.getName() %>
            </button>
        </form>
        <%
            }
        %>
    </div>
    <%
        } else {
    %>
    <p style="text-align: center;">No Service Categories Found</p>
    <%
        }
    %>
</div>

    <%@include file="footer.html" %>
    
</body>
</html>
