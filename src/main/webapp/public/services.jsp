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
  .container {
    display: flex;
  }
  .left-column {
    width: 25%;
    padding: 20px;
    border-right: 1px solid #ddd;
  }
  .right-column {
    width: 75%;
    padding: 20px;
  }
  .category {
    padding: 10px;
    cursor: pointer;
    background-color: #f2f2f2;
    margin-bottom: 10px;
    border-radius: 5px;
  }
  .category:hover {
    background-color: #ddd;
  }
  .service-list {
    margin-top: 20px;
  }
  .service-item {
    padding: 8px;
    background-color: #f9f9f9;
    margin-bottom: 5px;
    border-radius: 5px;
  }
  
</style>
</head>
<body>

<%@include file="header.jsp" %>
<div class="container">
  <!-- Left Column: Categories -->
  <div class="left-column">
    <h2>Service Categories</h2>
    
      <%-- Dynamically populate the categories --%>
      <%
        // Assume categories is a list of Category objects
        ServiceCategoryDAO dao = new ServiceCategoryDAO();
        List<ServiceCategory> categories = dao.getAllServiceCategories();

        for (ServiceCategory category : categories) {
      %>  <form action="showServiceByCategory.jsp?categoryId=<%= category.getId() %>" method="post">
              <div class="category">
                 <button class="categoryBtn">
                     <%= category.getName() %>
                 </button>
              </div>
          </form>
      <%
        }
      %>
   
  </div>


  <div class="right-column">
    <h2>Services</h2>
    <%
    

   List<Service> services = (List<Service>) session.getAttribute("services");

        if (services != null && !services.isEmpty()) {
    %>
           <h3>Services </h3>
            <table border="1">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
<%
                for (Service service : services) {
%>
                    <tr>
                        <td><%= service.getName() %></td>
                        <td><%= service.getDescription() %></td>
                        <td><%= service.getPrice() %></td>
                        <td><img src="images/cleaning.png" alt="<%= service.getName() %>" width="100" height="100"></td>
                        <td>
                            <form action="AddToCart" method="POST" style="display:inline;">
                                <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
                                <input type="submit" value="Add To Cart" />
                            </form>
                            <form action="bookAService.jsp" method="POST" style="display:inline;">
                                <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
                                <input type="hidden" name="serviceName" value="<%= service.getName() %>" />
                                <input type="submit" value="Book" />
                            </form>
                        </td>
                    </tr>
<%
                }
%>
                </tbody>
            </table>
<%
        } else {
        	%>
            <p>No category is selected.</p>
        <%
            }
        %>
        

  </div>
</div>
<%@include file="footer.html" %>
</body>
</html>
