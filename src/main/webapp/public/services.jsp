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
    flex-wrap: nowrap;  /* Prevent categories from wrapping to the next line */
    overflow-x: auto;   /* Enable horizontal scrolling */
    gap: 20px;          /* Space between each category table */
    padding: 20px;
  }
  .category-card-wrapper {
    min-width: 300px;   /* Set a minimum width for each category card */
    flex-shrink: 0;     /* Prevent the category card from shrinking */
  }
  .category-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
    padding: 20px;
    text-align: center;
    background-color: #fff;
  }
  .category-card h3 {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
  }
  .service-link {
    display: block;
    font-size: 18px;
    color: #0066cc;
    text-decoration: none;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
  .service-link:hover {
    background-color: #f1f1f1;
    text-decoration: underline;
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
</style>
</head>
<body>

<%@include file="header.jsp" %>
<h1>AVIALABLE SERVICES</h1>
<%
    String errorMessage = (String) request.getParameter("errorMsg");
    String successMessage = (String) request.getParameter("successMsg");
    if (errorMessage != null) {
%>
    <p class="editErr"><%= errorMessage %></p>
<% } 
    if (successMessage != null) { 
%>
    <p class="editSuccess"><%= successMessage %></p>
<% } %>

<div class="category-container">
  <% 
    // Fetch categories
    ServiceCategoryDAO dao = new ServiceCategoryDAO();
    List<ServiceCategory> categories = dao.getAllServiceCategories();
    

    // Loop through categories and display a card for each
    for (ServiceCategory category : categories) {
        int categoryId = category.getId();
        String categoryName = category.getName();
        String imageurl = category.getImage();
  %>
    <!-- Category card for each category -->
    <div class="category-card-wrapper">
      <div class="category-card">
        <h3><%= categoryName %> Services</h3>
       <img src="images/<%= category.getImage() %>" alt="<%= category.getName() %>" width="100" height="100" />
        <% 
            // Fetch services under this category
            ServiceDAO serviceDao = new ServiceDAO();
            List<Service> services = serviceDao.getServicesByCategory(categoryId);

            // Loop through services and display each service as a card
            for (Service service : services) { 
        %>
          <!-- Each service displayed as a clickable link in a card -->
          <a href="serviceDetails.jsp?serviceId=<%= service.getId() %>" class="service-link">
            <%= service.getName() %>
          </a>
        <% } %>
      </div>
    </div>
  <% } %>
</div>

<%@include file="footer.html" %>
</body>
</html>
