<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h1>User Registration</h1>
    <form action="Register" method="post">
        <label>Username:</label>
        <input type="text" name="username" required /><br>
        <label>Email:</label>
        <input type="email" name="email" required /><br>
        <label>Password:</label>
        <input type="password" name="password" required /><br>
        <label>Password:</label>
        <input type="password" name="password2" required /><br>
        <button type="submit">Register</button>
    </form>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <p style="color: red;"><%= errorMessage %></p>
    <%
        }
    %>
</body>
</html>
