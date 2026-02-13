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
    <title>Add Reservation - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="dashboard-body">

<jsp:include page="header.jsp" />

<div class="dashboard-container" style="padding-top: 50px; padding-bottom: 50px;">
    <div class="form-glass-box">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <h3 style="margin: 0; text-transform: uppercase; letter-spacing: 1px;">ADD NEW RESERVATION</h3>
            <a href="dashboard.jsp" style="color: #ddd; text-decoration: none; font-size: 12px;">← Back to Dashboard</a>
        </div>

        <form action="addReservationServlet" method="POST" onsubmit="return validateForm()">

            <div class="form-row">
                <div class="input-group">
                    <label style="text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 0.5px;">Guest Name</label>
                    <input type="text" name="guestName" required placeholder="Enter full name">
                </div>
                <div class="input-group">
                    <label style="text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 0.5px;">Contact Number</label>
                    <input type="text" name="contactNumber" id="contactNumber" required placeholder="07XXXXXXXX">
                    <small id="phoneError" style="color: #ff6b6b; display: none;">Must be 10 digits!</small>
                </div>
            </div>

            <div class="input-group">
                <label style="text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 0.5px;">Address</label>
                <input type="text" name="address" required placeholder="Enter full address">
            </div>

            <div class="input-group">
                <label style="text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 0.5px;">Room Type</label>
                <select name="roomType" required>
                    <option value="Single">Single Room (Rs. 10,000/night)</option>
                    <option value="Double">Double Room (Rs. 18,000/night)</option>
                    <option value="Deluxe">Deluxe Room (Rs. 30,000/night)</option>
                    <option value="Suite">Ocean View Suite (Rs. 50,000/night)</option>
                </select>
            </div>

            <div class="form-row">
                <div class="input-group">
                    <label style="text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 0.5px;">Check-in Date</label>
                    <input type="date" name="checkInDate" id="checkInDate" required>
                </div>
                <div class="input-group">
                    <label style="text-transform: uppercase; font-size: 11px; font-weight: 600; letter-spacing: 0.5px;">Check-out Date</label>
                    <input type="date" name="checkOutDate" id="checkOutDate" required>
                    <small id="dateError" style="color: #ff6b6b; display: none;">Invalid Date!</small>
                </div>
            </div>

            <button type="submit" class="submit-btn" style="margin-top: 20px; text-transform: uppercase; letter-spacing: 1px; font-weight: 600;">SAVE RESERVATION</button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>

    let today = new Date().toISOString().split('T')[0];
    document.getElementById("checkInDate").setAttribute('min', today);
    document.getElementById("checkOutDate").setAttribute('min', today);

    // Form function
    function validateForm() {
        let isValid = true;

        // Phone Number validation (10 num)
        let phone = document.getElementById("contactNumber").value;
        let phoneRegex = /^[0-9]{10}$/;

        if (!phone.match(phoneRegex)) {
            document.getElementById("phoneError").style.display = "block";
            isValid = false;
        } else {
            document.getElementById("phoneError").style.display = "none";
        }

        // Date Validation (Check-out after Check-in)
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

    // URL  Error Message
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status === 'unavailable') {
        alert("⚠️ ROOM UNAVAILABLE!\n\nSomeone has already booked this room for these dates.\nPlease select a different date or room type.");
    } else if (status === 'error') {
        alert("❌ ERROR!\n\nSomething went wrong. Please try again.");
    }
</script>

</body>
</html>