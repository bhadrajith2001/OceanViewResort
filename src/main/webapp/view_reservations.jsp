<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.models.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("index.html");
        return;
    }

    // ✅ Dynamic Title Logic
    String pageType = request.getParameter("type");
    String pageTitle = "MANAGE RESERVATIONS"; // Default Title

    if ("bill".equals(pageType)) {
        pageTitle = "GENERATE BILLS & INVOICES";
    } else if ("view".equals(pageType)) {
        pageTitle = "VIEW ALL RESERVATIONS";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= pageTitle %> - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard-body">

<jsp:include page="header.jsp" />

<div class="dashboard-container" style="padding-top: 50px; min-height: 80vh;">

    <div class="form-glass-box" style="width: 95%; max-width: 1200px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="text-transform: uppercase; letter-spacing: 1px;"><%= pageTitle %></h3>

            <div style="display: flex; gap: 10px; align-items: center;">
                <a href="add_reservation.jsp" class="submit-btn" style="width: auto; margin: 0; padding: 8px 15px; font-size: 12px;">+ Add New</a>

                <a href="dashboard.jsp" style="color: #333; text-decoration: none; font-size: 12px; border: 1px solid #ccc; padding: 8px 15px; border-radius: 20px; background: #f9f9f9;">
                    ← Back to Dashboard
                </a>
            </div>
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
                    <th>Room</th>
                    <th>Dates</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    ReservationDAO dao = new ReservationDAO();
                    List<Reservation> list = dao.getAllReservations();
                    if(list != null) {
                        for(Reservation r : list) {
                            String statusColor = "green";
                            if("Cancelled".equals(r.getStatus())) {
                                statusColor = "red";
                            }
                %>
                <tr>
                    <td><%= r.getId() %></td>
                    <td><%= r.getGuestName() %></td>
                    <td><%= r.getContact() %></td>
                    <td><span class="badge"><%= r.getRoomType() %></span></td>
                    <td>
                        <div style="font-size: 11px; color: #ccc;">In: <%= r.getCheckIn() %></div>
                        <div style="font-size: 11px; color: #ccc;">Out: <%= r.getCheckOut() %></div>
                    </td>
                    <td style="font-weight: bold; color: <%= statusColor %>;">
                        <%= (r.getStatus() == null || r.getStatus().isEmpty()) ? "Confirmed" : r.getStatus() %>
                    </td>
                    <td>
                        <a href="bill.jsp?id=<%=r.getId()%>&name=<%=r.getGuestName()%>&room=<%=r.getRoomType()%>&in=<%=r.getCheckIn()%>&out=<%=r.getCheckOut()%>&total=<%=String.format("%,.2f", r.getTotalBill())%>"
                           class="bill-btn" title="Print Bill">🧾</a>

                        <% if(!"Cancelled".equals(r.getStatus())) { %>
                        <a href="CancelReservationServlet?id=<%=r.getId()%>"
                           class="delete-btn" style="background: #f39c12;"
                           onclick="return confirm('Are you sure you want to CANCEL this booking?');"
                           title="Cancel Booking">🚫</a>
                        <% } %>

                        <a href="deleteReservationServlet?id=<%=r.getId()%>"
                           class="delete-btn" title="Delete Permanently"
                           onclick="return confirm('WARNING: This will permanently delete the record!');">🗑️</a>
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
            var tdID = tr[i].getElementsByTagName("td")[0];
            var tdName = tr[i].getElementsByTagName("td")[1];
            var tdPhone = tr[i].getElementsByTagName("td")[2];

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

<jsp:include page="footer.jsp" />
</body>
</html>