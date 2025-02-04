<%@page import="DAO.*" %>
<%@page import="bean.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Services</title>
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .category-container {
    display: flex;
    flex-wrap: nowrap;
    overflow-x: auto;
    gap: 20px;
    padding: 20px;
  }
  .category-card-wrapper {
    min-width: 300px;
    flex-shrink: 0;
  }
  .category-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    text-align: center;
    background-color: #fff;
  }
  .category-card h3 {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
  }
  .service-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    margin-bottom: 10px;
  }
  .service-link {
    display: inline-block;
    font-size: 18px;
    color: #31525b;
    text-decoration: none;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    flex-grow: 1;
  }
  .service-link:hover {
    background-color: #31525b;
    color: white;
  }
  .manage-btn {
    background-color: #f39c12;
    color: white;
    padding: 8px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
  }
  .manage-btn:hover {
    background-color: #e67e22;
  }
  .editErr {
    color: red;
    background-color: #fdecea;
    border: 1px solid red;
  }
  .editSuccess {
    color: green;
    background-color: #e7f9e7;
    border: 1px solid green;
  }
  fieldset {
    margin-bottom: 10px;
    background-color: #b3dee5;
    text-align: right;
  }
  #addNewCat {
    background-color: #31525b;
    color: white;
    text-align: left;
  }
  #availServ {
  	text-align: center;
  }
</style>
</head>
<body>

<%@include file="header.jsp" %>
<h1 id="availServ">AVAILABLE SERVICES</h1>

<%
    String errorMessage = request.getParameter("errorMsg");
    String successMessage = request.getParameter("successMsg");
    if (errorMessage != null) {
%>
    <p class="editErr"><%= errorMessage %></p>
<% } 
    if (successMessage != null) { 
%>
    <p class="editSuccess"><%= successMessage %></p>
<% } %>

<div class="category-container">

  <% if (isAdmin) { %>
    <!-- Move Add New Category Card to the Front -->
    <div class="category-card-wrapper">
      <div class="category-card" id="addNewCat">
        <h3 style="color: white;">+ Add New Category</h3>
        <form action="AddNewServiceCategory" method="post" enctype="multipart/form-data">
          <label for="serviceCategory">Category Name:</label>
          <input type="text" id="serviceCategory" name="serviceCategory" required><br>

          <label for="categoryImage">Category Image:</label>
          <input type="file" id="categoryImage" name="categoryImage" ><br><br>

          <button type="submit" class="manage-btn">Add Category</button>
        </form>
      </div>
    </div>
  <% } %>

  <% 
    ServiceCategoryDAO dao = new ServiceCategoryDAO();
    List<ServiceCategory> categories = dao.getAllServiceCategories();

    for (ServiceCategory category : categories) {
        int categoryId = category.getId();
        String categoryName = category.getName();
  %>
    <div class="category-card-wrapper">
      <div class="category-card">
        <h3><%= categoryName %> Services</h3>
        <img src="images/<%= category.getImage() %>" alt="<%= category.getName() %>" width="100" height="100" /><br>
        <%if (isAdmin){ %>
		<form action="updateCategory.jsp" method="post">
              <input type="hidden" name="categoryId" value="<%= categoryId %>">
              <button type="submit" class="manage-btn">Edit Category</button>
        </form><br><br>
        <%}
            ServiceDAO serviceDao = new ServiceDAO();
            List<Service> services = serviceDao.getServicesByCategory(categoryId);

            for (Service service : services) { 
        %>
          <div class="service-item">
            <a href="serviceDetails.jsp?serviceId=<%= service.getId() %>" class="service-link">
              <%= service.getName() %>
            </a>
            
          </div>
        <% } %>

        <% if (isAdmin) { %>
          <br><br>
          <h3>Add a new service under <%= categoryName %></h3>
          <fieldset>
            <form action="AddNewService" method="post">
              <input type="hidden" name="categoryId" value="<%= categoryId %>">

              <label for="service_name">Service Name:</label>
              <input type="text" id="service_name" name="serviceName" required><br>

              <label for="description">Description:</label>
              <textarea id="description" name="serviceDescription" rows="4" required></textarea><br>

              <label for="price">Price:</label>
              <input type="number" id="price" name="servicePrice" step="0.01" required><br><br>

              <button type="submit" class="manage-btn">Add Service</button>
            </form>
          </fieldset>
        <% } %>
      </div>
    </div>
  <% } %>

</div>

<%@include file="footer.html" %>
</body>
</html>
