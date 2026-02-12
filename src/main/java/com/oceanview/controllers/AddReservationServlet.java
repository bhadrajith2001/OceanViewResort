package com.oceanview.controllers;

import com.oceanview.dao.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addReservationServlet")
public class AddReservationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contactNumber");
        String roomType = request.getParameter("roomType");
        String checkIn = request.getParameter("checkInDate");
        String checkOut = request.getParameter("checkOutDate");

        ReservationDAO dao = new ReservationDAO();
        boolean isSuccess = dao.addReservation(name, address, contact, roomType, checkIn, checkOut);

        if (isSuccess) {
            //dashboard success message
            response.sendRedirect("dashboard.jsp?status=success");
        } else {
            //error message
            response.sendRedirect("dashboard.jsp?status=error");
        }
    }
}