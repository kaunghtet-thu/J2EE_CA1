<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Content</title>
</head>
<body>
    <%@ include file="header.jsp" %>

    <%
        // Retrieve the content and contentId from the form submission
        String contentId = request.getParameter("contentId");
        String content = request.getParameter("content");

        // Retrieve error and success codes from the request parameters
        String editErr = request.getParameter("errorCode");
        String editSuccess = request.getParameter("successCode");
    %>

    <h1>Edit Content</h1>

    <!-- Display error message if there is an error -->
    <% if (editErr != null && editErr.equals("editErr")) { %>
        <div class="editErr">There was an error while editing the content.</div>
    <% } %>

    <!-- Display success message if content was updated successfully -->
    <% if (editSuccess != null && editSuccess.equals("editSuccess")) { %>
        <div class="editSuccess">Content updated successfully!</div>
    <% } %>

    <!-- Form to handle the content update -->
    <form action="UpdateIndexContent" method="post">
        <input type="hidden" name="contentId" value="<%= contentId %>">
        <input type="hidden" name="isAdmin" value="<%= isAdmin %>">
        <label for="content">Edit Content:</label><br>
        <textarea name="content" rows="4" cols="50"><%= content %></textarea><br><br>

        <button type="submit">Save Changes</button>
    </form>

    <%@ include file="footer.html" %>

</body>
</html>
