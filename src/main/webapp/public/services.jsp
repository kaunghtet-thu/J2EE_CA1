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
  .editErr{
	 	color: red;
	    background-color: #fdecea;
	    border: 1px solid red;
   }
   .editSuccess {
	    color: green;
	    background-color: #e7f9e7;
	    border: 1px solid green;
	}
	button {
            background-color: #E3EED4;
        }
  
</style>

</head>
<body>

<%@include file="header.jsp" %>
<%
    String errorMessage = (String) request.getParameter("errorMsg");
	String successMessage = (String) request.getParameter("successMsg");
    if (errorMessage != null) {
%>
    <p class="editErr"><%= errorMessage %></p>
<% } ;
   if (successMessage != null) { %>
   
   <p class= "editSuccess"><%=successMessage%></p>
<%} %>

<div class="container">
  <!-- Left Column: Categories -->
  <div class="left-column">
    <h2>Service Categories</h2>

    <%-- Dynamically populate the categories --%>
    <%

        ServiceCategoryDAO dao = new ServiceCategoryDAO();
        List<ServiceCategory> categories = dao.getAllServiceCategories();

        for (ServiceCategory category : categories) {
    %>
        <div style="display: flex; align-items: center; margin-bottom: 50px;">
            <!-- Form for selecting the category -->
            <form action="services.jsp" method="POST" style="margin: 0; flex-grow: 1;">
                <input type="hidden" name="categoryId" value="<%= category.getId() %>" />
                <button type="submit" class="categoryBtn" style="width: 100%; text-align: left; padding: 10px; border: none; background-color: #f2f2f2; border-radius: 5px;">
                    <%= category.getName() %>
                </button>
            </form>

            <% if (isAdmin) { %>
                <!-- Form for deleting the category -->
                <form action="DeleteCategory" method="POST" style="margin: 0; margin-left: 10px;">
                    <input type="hidden" name="categoryId" value="<%= category.getId() %>" />
                    <button type="submit" style="background-color: red; color: white; border: none; padding: 10px; border-radius: 5px;">
                        Delete
                    </button>
                </form>
            <% } %>
        </div>
    <%
        }

      %>
      <% if (isAdmin){ %>
      	 <form action="AddNewServiceCategory" method="post">
		    <fieldset>
		      <legend>Add New Service Category</legend>
		      <input type="text" name="serviceCategory" placeholder="Enter new service category" required>
		      <button type="submit">Add</button>
		    </fieldset>
		  </form>
      <%} %>
   
  </div>


  <div class="right-column">
  
  <%
  int categoryIdFromLeftCol = request.getParameter("categoryId") != null ? Integer.parseInt(request.getParameter("categoryId")) : 1;
  String category = dao.getServiceCategoryById(categoryIdFromLeftCol).getName();
  %>
    <h2>Services under <%=category %></h2>
    <%

 
    	ServiceDAO serviceDao = new ServiceDAO();
    	 List<Service> services  = serviceDao.getServicesByCategory(categoryIdFromLeftCol);
    	  
    	  %>
 
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
                <!-- Hidden Form Row -->
			        <tr id="newServiceFormRow" class="hidden-form">
			          <form action="AddNewService" method="POST">
			          
			            <input type="hidden" name="categoryIdFromLeftCol" value="<%=categoryIdFromLeftCol %>" />
			            <td><input type="text" name="serviceName" placeholder="Service Name" required /></td>
			            <td><input type="text" name="serviceDescription" placeholder="Description" required /></td>
			            <td><input type="number" name="servicePrice" placeholder="Price" step="0.01" required /></td>
			            <td><input type="text" name="image" placeholder="Image Name" required /></td>
			            <td><input type="submit" value="Add New Service" /></td>
			          </form>
			        </tr>
				<% for (Service service : services) { %>
					   <tr>
					        <td><%= service.getName() %></td>
					        <td><%= service.getDescription() %></td>
					        <td><%= service.getPrice() %></td>
					        <td>
					            <img src="images/cleaning.png" alt="<%= service.getName() %>" width="100" height="100" />
					        </td>
					        <td> <% if (isMember) { %>
					            <form action="AddToCart" method="POST" style="display:inline;">
					                <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
					                <input type="submit" value="Add To Cart" />
					            </form>
					            <form action="bookAService.jsp" method="POST" style="display:inline;">
					                <input type="hidden" name="serviceId" value="<%= service.getId() %>" />
					                <input type="hidden" name="serviceName" value="<%= service.getName() %>" />
					                <input type="hidden" name="servicePrice" value="<%= service.getPrice() %>" />
					                <input type="submit" value="Book" />
					            </form>
					             <%} else if (isPublic) { %>
					             <form action="login.jsp" method="POST" style="display:inline;">
					                <input type="submit" value="Log in to book" />
					             </form>
					             <% } else if (isAdmin) { %>
					             <form action="updateService.jsp" method="POST" style="display:inline;">
					             	<input type="hidden" name="serviceId" value="<%= service.getId() %>" />
					                <input type="submit" value="Manage" />
					             </form>
					           
					             <%} %>
					        </td>   
						</tr>
					
					<% }%>
                </tbody>
            </table>

         

  </div>
</div>
<%@include file="footer.html" %>
</body>
</html>
