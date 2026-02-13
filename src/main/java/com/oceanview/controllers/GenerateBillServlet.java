package com.oceanview.controllers;

import com.oceanview.dao.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String room = request.getParameter("room");
            String checkIn = request.getParameter("in");
            String checkOut = request.getParameter("out");
            String totalStr = request.getParameter("total");

            double totalAmount = Double.parseDouble(totalStr.replace(",", ""));


            BillDAO dao = new BillDAO();
            dao.saveBill(id, name, totalAmount);


            response.sendRedirect("bill.jsp?id=" + id + "&name=" + name + "&room=" + room +
                    "&in=" + checkIn + "&out=" + checkOut + "&total=" + totalStr);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_reservations.jsp?error=true");
        }
    }
}