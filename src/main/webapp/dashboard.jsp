<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Ocean View</title>
</head>

<body>

<h2>Welcome, <%= session.getAttribute("loggedUser") %>!</h2>
<p>Your Role: <%= session.getAttribute("role") %></p>
<a href="index.html">Logout</a>

</body>
</html>