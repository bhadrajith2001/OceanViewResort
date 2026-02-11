package com.oceanview.controllers;

import com.oceanview.dao.UserDAO;
import com.oceanview.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uname = request.getParameter("username");
        String pass = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User loggedInUser = userDAO.authenticateUser(uname, pass);

        if (loggedInUser != null) {
            // Login Success!
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", loggedInUser.getUsername());
            session.setAttribute("role", loggedInUser.getRole());

            response.sendRedirect("dashboard.jsp");
        } else {
            // Login Failed!
            response.sendRedirect("index.html?error=invalid_login");
        }
    }
}