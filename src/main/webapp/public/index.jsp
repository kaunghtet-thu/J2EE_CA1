<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bean.*" %>
<%@ page import="java.util.*" %>
<%@ page import="DAO.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SPOTLESS</title>
  <style>
    /* General page styling */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    /* Section title */
    h2 {
        text-align: center;
        font-size: 1.5em;
        margin-top: 20px;
        color: #333;
    }

    /* Main container for the categories */
    .category {
        width: 80%;
        max-width: 600px;
        margin: 20px auto;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    /* Individual category item styling */
    .categoryItem {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        border-bottom: 1px solid #ddd;
        font-size: 1.1em;
        font-weight: bold;
        color: #333;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    /* Last item - remove bottom border */
    .categoryItem:last-child {
        border-bottom: none;
    }

    /* Dropdown arrow styling */
    .dropdown-arrow {
        font-size: 1.2em;
        color: #666;
        transition: transform 0.3s ease;
    }

    /* Hover effect for category items */
    .categoryItem:hover {
        background-color: #f7f7f7;
    }

    /* Rotate arrow on hover */
    .categoryItem:hover .dropdown-arrow {
        transform: rotate(180deg);
    }
    .center {
    text-align: center;
    font-family: Arial, sans-serif;
    padding: 20px;
}

.category-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 400px;
    margin: 0 auto;
}

.category-item {
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #f8f9fa;
    padding: 10px;
    transition: background-color 0.3s, transform 0.2s;
    cursor: pointer;
}

.category-item:hover {
    background-color: #e9ecef;
    transform: translateY(-2px);
}

.category-link {
    all: unset; /* Reset button styles */
    font-size: 16px;
    font-weight: bold;
    color: #007bff;
    cursor: pointer;
    text-align: left;
    display: block;
    width: 100%;
    transition: color 0.3s;
}

.category-link:hover {
    color: #0056b3;
}
    
</style>

</head>
<body>
<%@include file="header.jsp" %>


<h1>Welcome from SPOTLESS</h1>
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
</p>
<h2>Book a service in 4 steps</h2>
<table border="1">
	<tr>
		<td>1. Pick a service </td>
		<td>2. Choose date and time</td>
		<td>3. Confirm address</td>
		<td>4. Checkout</td>
	</tr>
</table>

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




<%@ include file="footer.html" %>
</body>
</html>