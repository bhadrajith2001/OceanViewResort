<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice - Ocean View Resort</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background: #eee;
            padding: 40px;
        }
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            color: #555;
        }
        .header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
        }
        .header h1 {
            color: #2ca1bd;
            margin: 0;
        }
        .header p {
            margin: 5px 0;
            font-size: 14px;
        }
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .details-table td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .total-row td {
            border-top: 2px solid #333;
            font-weight: bold;
            font-size: 18px;
            color: #333;
            padding-top: 15px;
        }
        .print-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background: #2ca1bd;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            font-size: 16px;
        }
        .print-btn:hover { background: #1b7a91; }


        @media print {
            .print-btn { display: none; }
            body { background: white; }
            .invoice-box { box-shadow: none; border: none; }
        }
    </style>
</head>
<body>

<div class="invoice-box">
    <div class="header">
        <div>
            <h1>Ocean View Resort</h1>
            <p>123 Galle Road, Galle, Sri Lanka</p>
            <p>Hotline: +94 91 222 3333</p>
        </div>
        <div style="text-align: right;">
            <h3>INVOICE</h3>
            <p>Invoice #: INV-2026-<%= request.getParameter("id") %></p>
            <p>Date: <%= new java.util.Date() %></p>
        </div>
    </div>

    <hr style="border: 0; border-top: 1px solid #eee; margin-bottom: 20px;">

    <p><strong>Bill To:</strong><br>
        <%= request.getParameter("name") %></p>

    <table class="details-table">
        <tr style="background: #f9f9f9; font-weight: bold;">
            <td>Description</td>
            <td style="text-align: right;">Details</td>
        </tr>
        <tr>
            <td>Room Type</td>
            <td style="text-align: right;"><%= request.getParameter("room") %> Room</td>
        </tr>
        <tr>
            <td>Check-In Date</td>
            <td style="text-align: right;"><%= request.getParameter("in") %></td>
        </tr>
        <tr>
            <td>Check-Out Date</td>
            <td style="text-align: right;"><%= request.getParameter("out") %></td>
        </tr>

        <tr class="total-row">
            <td>Total Amount (Tax Included)</td>
            <td style="text-align: right;">Rs. <%= request.getParameter("total") %></td>
        </tr>
    </table>

    <p style="text-align: center; margin-top: 50px; font-size: 12px; color: #888;">
        Thank you for staying with Ocean View Resort!<br>
        This is a computer-generated invoice.
    </p>

    <button onclick="window.print()" class="print-btn">Print Invoice / Save as PDF</button>
    <div style="text-align: center; margin-top: 10px;">
        <a href="dashboard.jsp" style="color: #888; text-decoration: none; font-size: 12px;">Go Back</a>
    </div>
</div>

</body>
</html>