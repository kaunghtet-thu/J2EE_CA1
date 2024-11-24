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
    h1,h2 {
        text-align: center;
        font-size: 1.5em;
        margin-top: 20px;
        color: #333;
    }
    p{
     text-align: center;
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
    
</style>

</head>
<body>
<%@include file="header.jsp" %>
<%
	IndexDAO indexDao = new IndexDAO();
	ArrayList<String> contents = indexDao.getContent();
	 String editErr = request.getParameter("errorCode");
	    String editSuccess = request.getParameter("successCode");
	    if (editErr != null && editErr.equals("editErr")) {
		
	%>
		<div class="editErr">
			<p>Error editing the selected field</p>
		</div>
		<%} 
		
		if (editSuccess != null && editSuccess.equals("editSuccess")) {

		%>
		<div class="editSuccess">
			<p>Editing the selected field successful</p>
		</div>
		<%} %>


<h1>
    <%= contents.get(0) %>
    <% if (isAdmin) { %>
        <form action="editContent.jsp" method="post" style="display:inline;">
            <input type="hidden" name="contentId" value="1">
            <input type="hidden" name="content" value ="<%=contents.get(0) %>">
            <button type="submit" class="edit-button">Edit</button>
        </form>
    <% } %>
</h1>


<p>
    <%= contents.get(1) %>
    <% if (isAdmin) { %>
        <form action="editContent.jsp" method="post" style="display:inline;">
            <input type="hidden" name="contentId" value="2"> <!-- Adjust the index here -->
            <input type="hidden" name="content" value="<%= contents.get(1) %>">
            <button type="submit" class="edit-button">Edit</button>
        </form>
    <% } %>
</p>

 <div class="center">
	<h2>
	    <%= contents.get(2) %>
	    <% if (isAdmin) { %>
	        <form action="editContent.jsp" method="post" style="display:inline;">
	            <input type="hidden" name="contentId" value="3"> <!-- Adjust the index here -->
	            <input type="hidden" name="content" value="<%= contents.get(2) %>">
	            <button type="submit" class="edit-button">Edit</button>
	        </form>
	    <% } %>
	</h2>
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
        <form action="showServicesByCategory.jsp" method="post" class="category-item">
            <input type="hidden" name="categoryId" value="<%= category.getId() %>">

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
<h2></h2>
<div>
</div>

<%@ include file="footer.html" %>
</body>
</html>