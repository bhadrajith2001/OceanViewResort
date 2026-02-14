package com.oceanview.controllers;

import com.oceanview.dao.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CancelReservationServlet")
public class CancelReservationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            ReservationDAO dao = new ReservationDAO();
            boolean isCancelled = dao.cancelReservation(id);

            if (isCancelled) {
                response.sendRedirect("view_reservations.jsp?status=cancelled");
            } else {
                response.sendRedirect("view_reservations.jsp?status=error");
            }
        }
    }

}