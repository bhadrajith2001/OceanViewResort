<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("index.html");
        return;
    }

    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(new Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Invoice - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">

    <style>

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .invoice-container-wrapper {
            flex: 1;
            padding: 50px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .invoice-box {
            width: 100%;
            max-width: 800px;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            position: relative;
            box-sizing: border-box;
        }


        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            border-bottom: 2px solid #2ca1bd;
            padding-bottom: 20px;
        }
        .header h1 { color: #2ca1bd; margin: 0; font-size: 28px; text-transform: uppercase; }
        .header p { margin: 5px 0; font-size: 13px; color: #777; }

        /* --- Table Styles --- */
        .details-table { width: 100%; border-collapse: collapse; margin-top: 20px; margin-bottom: 30px; }
        .details-table th { background: #f4f4f4; padding: 12px; text-align: left; font-weight: 600; color: #333; border-bottom: 1px solid #ddd; }
        .details-table td { padding: 12px; border-bottom: 1px solid #eee; }
        .details-table td:last-child, .details-table th:last-child { text-align: right; }
        .total-row td { border-top: 2px solid #333; font-weight: bold; font-size: 20px; color: #2ca1bd; padding-top: 15px; }

        .print-btn {
            background: #2ca1bd; color: white; padding: 12px 30px; text-decoration: none; border-radius: 50px; cursor: pointer; border: none; font-size: 15px; font-weight: 600; transition: 0.3s;
        }
        .print-btn:hover { background: #1b7a91; transform: translateY(-2px); }
        .back-link { display: inline-block; margin-top: 20px; color: #ddd; text-decoration: none; font-size: 13px; }


        @media (max-width: 600px) {
            .invoice-box {
                padding: 20px;
            }
            .header {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            .header div {
                text-align: center !important;
                width: 100%;
            }
            .header h1 { font-size: 24px; }
            .details-table th, .details-table td {
                padding: 8px;
                font-size: 13px;
            }
            .total-row td { font-size: 16px; }
        }


        @media print {
            body { background: white !important; display: block; }
            .no-print { display: none !important; }
            .invoice-container-wrapper { padding: 0; margin: 0; display: block; }
            .invoice-box { box-shadow: none; border: none; width: 100%; max-width: none; margin: 0; padding: 20px; }
        }
    </style>
</head>
<body>

<div class="no-print">
    <jsp:include page="header.jsp" />
</div>

<div class="invoice-container-wrapper">
    <div class="invoice-box">

        <div class="header">
            <div>
                <h1>Ocean View Resort</h1>
                <p>123 Galle Road, Galle, Sri Lanka</p>
                <p>Email: info@oceanview.lk | Hotline: +94 91 222 3333</p>
            </div>
            <div style="text-align: right;">
                <h2 style="color: #555; margin: 0;">INVOICE</h2>
                <p style="font-weight: bold;">#INV-<%= request.getParameter("id") %></p>
                <p>Date: <%= formattedDate %></p>
            </div>
        </div>

        <div style="margin-bottom: 30px;">
            <p style="color: #888; font-size: 12px; text-transform: uppercase; margin-bottom: 5px;">Bill To:</p>
            <h3 style="margin: 0; color: #333;"><%= request.getParameter("name") %></h3>
        </div>

        <table class="details-table">
            <thead>
            <tr>
                <th>Description</th>
                <th>Details / Amount</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Accommodation Type</td>
                <td><%= request.getParameter("room") %> Room</td>
            </tr>
            <tr>
                <td>Check-In Date</td>
                <td><%= request.getParameter("in") %></td>
            </tr>
            <tr>
                <td>Check-Out Date</td>
                <td><%= request.getParameter("out") %></td>
            </tr>
            <tr>
                <td style="color: #999; font-size: 12px; font-style: italic;">Note: Includes Service Charge & Taxes (10%)</td>
                <td></td>
            </tr>
            <tr class="total-row">
                <td>Total Amount Paid</td>
                <td>Rs. <%= request.getParameter("total") %></td>
            </tr>
            </tbody>
        </table>

        <div style="text-align: center; margin-top: 60px; padding-top: 20px; border-top: 1px solid #eee;">
            <p style="font-weight: 600; color: #333;">Thank you for choosing Ocean View Resort!</p>
            <p style="font-size: 12px; color: #aaa;">This is a computer-generated invoice and requires no signature.</p>
        </div>

        <div class="no-print" style="text-align: center; margin-top: 30px;">
            <button onclick="window.print()" class="print-btn">🖨️ Print Invoice / Save PDF</button>
        </div>
    </div>
</div>

<div class="no-print" style="text-align: center; margin-bottom: 30px;">
    <a href="dashboard.jsp" class="back-link">← Back to Dashboard</a>
</div>

<div class="no-print">
    <jsp:include page="footer.jsp" />
</div>

</body>
</html>