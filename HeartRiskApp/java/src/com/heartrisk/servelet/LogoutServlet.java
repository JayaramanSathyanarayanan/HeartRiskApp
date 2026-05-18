package com.heartrisk.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        HttpSession httpSession = paramHttpServletRequest.getSession(false);
        if (httpSession != null) httpSession.invalidate();

        Cookie cookie = new Cookie("hr_remember", "");
        cookie.setMaxAge(0);
        cookie.setPath(paramHttpServletRequest.getContextPath() + "/");
        paramHttpServletResponse.addCookie(cookie);

        paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/login?logout=1");
    }
}