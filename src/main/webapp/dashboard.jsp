<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("index.html?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Add Reservation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-body">

<div class="navbar glass-nav">
    <h2>Ocean View Resort</h2>
    <div class="user-info">
        <span>Welcome, <b><%= session.getAttribute("loggedUser") %></b> (<%= session.getAttribute("role") %>)</span>
        <a href="logoutServlet" class="logout-btn">Logout</a>
    </div>
</div>

<div class="dashboard-container">
    <div class="form-glass-box">
        <h3>Add New Reservation</h3>
        <form id="reservationForm" action="addReservationServlet" method="POST" onsubmit="return validateForm()">

            <div class="form-row">
                <div class="input-group">
                    <label>Guest Name</label>
                    <input type="text" name="guestName" id="guestName" required placeholder="Enter full name">
                </div>
                <div class="input-group">
                    <label>Contact Number</label>
                    <input type="text" name="contactNumber" id="contactNumber" required placeholder="07XXXXXXXX">
                    <small id="phoneError" style="color: #ff6b6b; display: none;">Must be exactly 10 digits!</small>
                </div>
            </div>

            <div class="input-group">
                <label>Address</label>
                <input type="text" name="address" required placeholder="Enter full address">
            </div>

            <div class="form-row">
                <div class="input-group">
                    <label>Room Type</label>
                    <select name="roomType" required>
                        <option value="Single">Standard Room (RS. 10,000/night)</option>
                        <option value="Double">Double Room (Rs. 18,000/night)</option>
                        <option value="Deluxe">Deluxe Suite (Rs. 30,000/night)</option>
                        <option value="Suite">Ocean View Suite (Rs. 50,000/night)</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="input-group">
                    <label>Check-in Date</label>
                    <input type="date" name="checkInDate" id="checkInDate" required>
                </div>
                <div class="input-group">
                    <label>Check-out Date</label>
                    <input type="date" name="checkOutDate" id="checkOutDate" required>
                    <small id="dateError" style="color: #ff6b6b; display: none;">Check-out must be after Check-in!</small>
                </div>
            </div>

            <button type="submit" class="submit-btn">Save Reservation</button>
        </form>
    </div>
</div>

<div class="table-glass-box" style="margin-top: 30px;">
    <h3>Current Reservations</h3>
    <table class="styled-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Guest Name</th>
            <th>Room Type</th>
            <th>Check-In</th>
            <th>Check-Out</th>
            <th>Total Bill (Rs.)</th>
            <th>Action</th> </tr>
        </thead>
        <tbody>
        <%
            com.oceanview.dao.ReservationDAO dao = new com.oceanview.dao.ReservationDAO();
            java.util.List<com.oceanview.models.Reservation> list = dao.getAllReservations();

            if(list != null) {
                for(com.oceanview.models.Reservation r : list) {

                    String totalFormatted = String.format("%,.2f", r.getTotalBill());
        %>
        <tr>
            <td><%= r.getId() %></td>
            <td><%= r.getGuestName() %></td>
            <td><span class="badge"><%= r.getRoomType() %></span></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td style="font-weight: bold; color: #2ed573;">Rs. <%= totalFormatted %></td>

            <td>
                <a href="bill.jsp?id=<%=r.getId()%>&name=<%=r.getGuestName()%>&room=<%=r.getRoomType()%>&in=<%=r.getCheckIn()%>&out=<%=r.getCheckOut()%>&total=<%=totalFormatted%>"
                   class="bill-btn" target="_blank">View Bill</a>
            </td>
        </tr>
        <%      }
        } %>
        </tbody>
    </table>
</div>

<script>

    let today = new Date().toISOString().split('T')[0];
    document.getElementById("checkInDate").setAttribute('min', today);
    document.getElementById("checkOutDate").setAttribute('min', today);

    function validateForm() {
        let isValid = true;


        let phone = document.getElementById("contactNumber").value;
        let phoneRegex = /^[0-9]{10}$/;
        if (!phone.match(phoneRegex)) {
            document.getElementById("phoneError").style.display = "block";
            isValid = false;
        } else {
            document.getElementById("phoneError").style.display = "none";
        }


        let checkIn = document.getElementById("checkInDate").value;
        let checkOut = document.getElementById("checkOutDate").value;
        if (checkIn && checkOut && checkOut <= checkIn) {
            document.getElementById("dateError").style.display = "block";
            isValid = false;
        } else {
            document.getElementById("dateError").style.display = "none";
        }

        return isValid;
    }
</script>
</body>
</html>