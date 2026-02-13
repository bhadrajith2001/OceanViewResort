<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.models.Reservation" %>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Dashboard - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">

    <style>
        /* --- Dashboard Layout Styles --- */


        .dashboard-wrapper {
            display: flex;
            gap: 30px;
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            align-items: flex-start;
        }


        .action-panel {
            flex: 2;
        }


        .stats-panel {
            flex: 1;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            backdrop-filter: blur(10px);
        }


        .card-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* Dashboard Card Design */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            padding: 30px 20px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            transition: all 0.3s ease;
            color: white;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 200px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            border-color: #2ca1bd;
        }

        .icon-circle {
            background: rgba(44, 161, 189, 0.2);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-bottom: 15px;
            border: 1px solid rgba(44, 161, 189, 0.5);
        }

        .dashboard-card h3 { font-size: 20px; margin-bottom: 5px; color: #fff; }
        .dashboard-card p { font-size: 13px; color: #ddd; margin: 0; }

        /*RESPONSIVE CODE*/
        @media (max-width: 900px) {
            .dashboard-wrapper {
                flex-direction: column;
            }
            .action-panel, .stats-panel {
                width: 100%;
            }
        }

        @media (max-width: 600px) {
            .card-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="dashboard-body">

<div class="glass-nav">
    <h2>Ocean View Resort</h2>
    <div class="user-info">
        <span>Welcome, <b><%= session.getAttribute("loggedUser") %></b></span>
        <a href="logoutServlet" class="logout-btn">Logout</a>
    </div>
</div>

<div class="dashboard-wrapper">

    <div class="action-panel">
        <h2 style="color: white; margin-bottom: 20px; text-shadow: 0 2px 4px rgba(0,0,0,0.3);">Quick Actions</h2>

        <div class="card-grid">
            <a href="add_reservation.jsp" class="dashboard-card">
                <div class="icon-circle">➕</div>
                <h3>Add Reservation</h3>
                <p>Create a new booking</p>
            </a>

            <a href="view_reservations.jsp" class="dashboard-card">
                <div class="icon-circle">🔍</div>
                <h3>View Reservations</h3>
                <p>Search & Manage</p>
            </a>

            <a href="view_reservations.jsp" class="dashboard-card">
                <div class="icon-circle">🧾</div>
                <h3>Generate Bill</h3>
                <p>Print invoices</p>
            </a>

            <a href="help.jsp" class="dashboard-card">
                <div class="icon-circle">❓</div>
                <h3>Help & Guide</h3>
                <p>Instructions</p>
            </a>
        </div>
    </div>

    <div class="stats-panel">
        <h3 style="color: #333; margin-bottom: 5px;">Live Statistics</h3>
        <p style="color: #777; font-size: 13px; margin-bottom: 25px;">Real-time Data</p>

        <%
            ReservationDAO dao = new ReservationDAO();
            List<Reservation> list = dao.getAllReservations();

            int totalBookings = 0;
            int activeBookings = 0;
            double totalRevenue = 0.0;

            java.time.LocalDate today = java.time.LocalDate.now();

            if (list != null) {
                totalBookings = list.size();
                for (Reservation r : list) {
                    totalRevenue += r.getTotalBill();
                    try {
                        java.time.LocalDate outDate = java.time.LocalDate.parse(r.getCheckOut());
                        if (outDate.isAfter(today) || outDate.isEqual(today)) {
                            activeBookings++;
                        }
                    } catch (Exception e) {}
                }
            }
        %>

        <div style="margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
            <h4 style="margin: 0; color: #555;">Total Reservations</h4>
            <h1 style="margin: 0; color: #2f3542; font-size: 32px;"><%= totalBookings %></h1>
        </div>

        <div style="margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px;">
            <h4 style="margin: 0; color: #1e88e5;">Active Reservations</h4>
            <h1 style="margin: 0; color: #1565c0; font-size: 32px;"><%= activeBookings %></h1>
        </div>

        <div>
            <h4 style="margin: 0; color: #43a047;">Total Revenue</h4>
            <h2 style="margin: 5px 0; color: #2e7d32; font-size: 24px;">Rs. <%= String.format("%,.0f", totalRevenue) %></h2>
        </div>
    </div>

</div>

<script>

    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');


    if (status === 'success') {
        alert("✅ SUCCESS!\n\nNew Reservation has been saved successfully!");


        window.history.replaceState(null, null, window.location.pathname);
    }
    else if (status === 'deleted') {
        alert("🗑️ DELETED!\n\nReservation removed successfully.");
        window.history.replaceState(null, null, window.location.pathname);
    }
</script>
</body>
</html>

<jsp:include page="footer.jsp" />

</body>
</html>