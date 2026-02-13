<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="glass-nav">
    <div style="display: flex; align-items: center; gap: 15px;">
        <h2>Ocean View Resort</h2>
    </div>

    <div class="user-info">
        <a href="dashboard.jsp" style="color: white; text-decoration: none; margin-right: 15px; font-size: 14px;">🏠 Home</a>

        <span>Welcome, <b><%= session.getAttribute("loggedUser") %></b></span>

        <a href="logoutServlet" class="logout-btn">Logout</a>
    </div>
</div>