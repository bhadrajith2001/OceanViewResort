<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help & Support - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="dashboard-body">

<jsp:include page="header.jsp" />

<div class="dashboard-wrapper"></div>

<div class="dashboard-container" style="flex-direction: column; align-items: center;">
    <div class="form-glass-box" style="max-width: 800px;">
        <div style="text-align: center; margin-bottom: 30px;">
            <h3>System Help Guide</h3>
            <p>How to use the Reservation Management System</p>
        </div>

        <div style="text-align: left; padding: 0 20px;">
            <h4 style="color: #2ca1bd;">1. How to Add a Reservation?</h4>
            <p style="margin-bottom: 20px; font-size: 14px; color: #ddd;">
                Go to the <b>Dashboard</b> and click on <b>"Add Reservation"</b>. Fill in the guest details, select the room type, and choose dates. The system will automatically check if the room is available.
            </p>

            <h4 style="color: #2ca1bd;">2. How to Generate a Bill?</h4>
            <p style="margin-bottom: 20px; font-size: 14px; color: #ddd;">
                Go to <b>"View / Search"</b>. Find the relevant booking and click on the orange <b>"Bill"</b> button. You can then print or save the invoice as a PDF.
            </p>

            <h4 style="color: #2ca1bd;">3. How to Cancel/Delete?</h4>
            <p style="margin-bottom: 20px; font-size: 14px; color: #ddd;">
                In the <b>"View / Search"</b> page, click the red <b>"Del"</b> button next to the reservation. Confirm the action to remove it from the database.
            </p>

            <h4 style="color: #2ca1bd;">4. Contact Support</h4>
            <p style="margin-bottom: 20px; font-size: 14px; color: #ddd;">
                For technical issues, please contact the IT Admin at <b>admin@oceanview.lk</b>.
            </p>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="dashboard.jsp" class="submit-btn" style="width: auto; padding: 10px 30px; text-decoration: none;">Back to Dashboard</a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>