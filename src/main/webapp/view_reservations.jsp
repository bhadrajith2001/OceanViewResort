<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Reservations - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-body">

<div class="glass-nav">
    <h2>Ocean View Resort</h2>
    <div class="user-info">
        <a href="dashboard.jsp" class="nav-link">Home</a>
        <a href="logoutServlet" class="logout-btn">Logout</a>
    </div>
</div>

<div class="dashboard-container" style="flex-direction: column; align-items: center;">

    <div class="form-glass-box" style="width: 95%; max-width: 1200px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3>Manage Reservations</h3>
            <a href="add_reservation.jsp" class="submit-btn" style="width: auto; margin: 0; padding: 10px 20px;">+ Add New</a>
        </div>

        <div class="search-box" style="margin-bottom: 20px;">
            <input type="text" id="searchInput" onkeyup="searchTable()"
                   placeholder="🔍 Search by ID, Name or Phone..." style="width: 100%; box-sizing: border-box;">
        </div>

        <div style="overflow-x: auto;">
            <table class="styled-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Guest Name</th>
                    <th>Contact</th>
                    <th>Room Type</th>
                    <th>Check-In</th>
                    <th>Check-Out</th>
                    <th>Total Bill</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    com.oceanview.dao.ReservationDAO dao = new com.oceanview.dao.ReservationDAO();
                    java.util.List<com.oceanview.models.Reservation> list = dao.getAllReservations();
                    if(list != null) {
                        for(com.oceanview.models.Reservation r : list) {
                %>
                <tr>
                    <td><%= r.getId() %></td>
                    <td><%= r.getGuestName() %></td>
                    <td><%= r.getContact() %></td>
                    <td><span class="badge"><%= r.getRoomType() %></span></td>
                    <td><%= r.getCheckIn() %></td>
                    <td><%= r.getCheckOut() %></td>
                    <td style="font-weight: bold; color: #2ed573;">Rs. <%= String.format("%,.2f", r.getTotalBill()) %></td>
                    <td>
                        <a href="bill.jsp?id=<%=r.getId()%>&name=<%=r.getGuestName()%>&room=<%=r.getRoomType()%>&in=<%=r.getCheckIn()%>&out=<%=r.getCheckOut()%>&total=<%=r.getTotalBill()%>"
                           class="bill-btn" target="_blank">Bill</a>
                        <a href="deleteReservationServlet?id=<%=r.getId()%>"
                           class="delete-btn" onclick="return confirm('Delete this reservation?');">Del</a>
                    </td>
                </tr>
                <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function searchTable() {
        var input = document.getElementById("searchInput");
        var filter = input.value.toUpperCase();
        var table = document.querySelector(".styled-table");
        var tr = table.getElementsByTagName("tr");

        for (var i = 0; i < tr.length; i++) {
            var tdID = tr[i].getElementsByTagName("td")[0];   // ID Column
            var tdName = tr[i].getElementsByTagName("td")[1]; // Name Column
            var tdPhone = tr[i].getElementsByTagName("td")[2]; // Phone Column

            if (tdID || tdName || tdPhone) {
                var idVal = tdID.textContent || tdID.innerText;
                var nameVal = tdName.textContent || tdName.innerText;
                var phoneVal = tdPhone.textContent || tdPhone.innerText;


                if (idVal.toUpperCase().indexOf(filter) > -1 ||
                    nameVal.toUpperCase().indexOf(filter) > -1 ||
                    phoneVal.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>
</body>
</html>