package com.heartrisk.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/info/developers"})
public class DevelopersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {
        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/info/developers.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }
}