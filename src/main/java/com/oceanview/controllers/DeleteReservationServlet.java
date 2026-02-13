package com.oceanview.controllers;

import com.oceanview.dao.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteReservationServlet")
public class DeleteReservationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            ReservationDAO dao = new ReservationDAO();
            boolean isDeleted = dao.deleteReservation(id);

            if (isDeleted) {
                response.sendRedirect("dashboard.jsp?status=deleted");
            } else {
                response.sendRedirect("dashboard.jsp?status=error");
            }
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
}