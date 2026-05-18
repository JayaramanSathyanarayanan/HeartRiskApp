package com.heartrisk.servlet;

import com.heartrisk.dao.UserDAO;
import com.heartrisk.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        HttpSession httpSession = paramHttpServletRequest.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/dashboard");
            return;
        }

        String str = null;
        Cookie[] arrayOfCookie = paramHttpServletRequest.getCookies();

        if (arrayOfCookie != null) {
            for (Cookie cookie : arrayOfCookie) {
                if ("hr_remember".equals(cookie.getName())) {
                    str = cookie.getValue();
                    break;
                }
            }
        }

        paramHttpServletRequest.setAttribute("rememberedUser", str);

        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/login.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }

    protected void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        String str1 = paramHttpServletRequest.getParameter("username");
        String str2 = paramHttpServletRequest.getParameter("password");
        boolean bool = "on".equals(paramHttpServletRequest.getParameter("rememberMe"));

        if (str1 == null || str1.isBlank() || str2 == null || str2.isBlank()) {
            paramHttpServletRequest.setAttribute("error", "Username and password are required.");
            paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
            return;
        }

        User user = this.userDAO.authenticate(str1.trim(), str2);

        if (user == null) {
            paramHttpServletRequest.setAttribute("error", "Invalid username or password.");
            paramHttpServletRequest.setAttribute("rememberedUser", str1);
            paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
            return;
        }

        HttpSession httpSession = paramHttpServletRequest.getSession(true);
        httpSession.setAttribute("user", user);
        httpSession.setMaxInactiveInterval(1800);

        if (bool) {
            Cookie cookie = new Cookie("hr_remember", user.getUsername());
            cookie.setMaxAge(604800);
            cookie.setHttpOnly(true);
            cookie.setPath(paramHttpServletRequest.getContextPath() + "/");
            paramHttpServletResponse.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("hr_remember", "");
            cookie.setMaxAge(0);
            cookie.setPath(paramHttpServletRequest.getContextPath() + "/");
            paramHttpServletResponse.addCookie(cookie);
        }

        paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/dashboard");
    }
}