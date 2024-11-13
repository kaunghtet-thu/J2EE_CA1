<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.ServiceCategory" %>
<%@ page import="java.util.ArrayList" %>

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
</style>

</head>
<body>
<%@ include file="header.html" %>
<h1>Welcome from SPOTLESS</h1>
<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
</p>

<h2>Services available</h2>
<%
    // Sample ArrayList containing industry names (replace with your own ArrayList)
    ArrayList<String> categories = new ArrayList<>();
		categories.add("F&B INDUSTRY");
		categories.add("COSMETIC INDUSTRY");
		categories.add("FLORAL & GIFT INDUSTRY");
		categories.add("MODERN TRADE RETAIL INDUSTRY");
%>
 <div class="category">
        <%
            for (String categotry : categories) {
        %>
            <div class="categoryItem">
                <span><%= categotry %></span>
                <span class="dropdown-arrow">&#9662;</span>
            </div>
        <%
            }
        %>
    </div>
<%@ include file="footer.html" %>
</body>
</html>