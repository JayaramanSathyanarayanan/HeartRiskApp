package com.heartrisk.servlet;

import com.heartrisk.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        HttpSession httpSession = paramHttpServletRequest.getSession(false);
        if (httpSession != null && httpSession.getAttribute("user") != null) {
            paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/dashboard");
            return;
        }

        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/register.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }

    protected void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        String str1 = paramHttpServletRequest.getParameter("fullName");
        String str2 = paramHttpServletRequest.getParameter("username");
        String str3 = paramHttpServletRequest.getParameter("email");
        String str4 = paramHttpServletRequest.getParameter("password");
        String str5 = paramHttpServletRequest.getParameter("confirmPassword");

        if (str1 == null || str1.isBlank()) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Full name is required.", str1, str2, str3);
            return;
        }

        if (str2 == null || str2.length() < 3) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Username must be at least 3 characters.", str1, str2, str3);
            return;
        }

        if (str3 == null || !str3.contains("@")) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Enter a valid email address.", str1, str2, str3);
            return;
        }

        if (str4 == null || str4.length() < 6) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Password must be at least 6 characters.", str1, str2, str3);
            return;
        }

        if (!str4.equals(str5)) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Passwords do not match.", str1, str2, str3);
            return;
        }

        if (this.userDAO.usernameExists(str2.trim())) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Username already taken. Please choose another.", str1, str2, str3);
            return;
        }

        if (this.userDAO.emailExists(str3.trim())) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "An account with this email already exists.", str1, str2, str3);
            return;
        }

        boolean bool = this.userDAO.register(str2.trim(), str4, str1.trim(), str3.trim());

        if (!bool) {
            fail(paramHttpServletRequest, paramHttpServletResponse, "Registration failed. Please try again.", str1, str2, str3);
            return;
        }

        paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/login?registered=1");
    }

    private void fail(HttpServletRequest paramHttpServletRequest,
                      HttpServletResponse paramHttpServletResponse,
                      String paramString1,
                      String paramString2,
                      String paramString3,
                      String paramString4) throws ServletException, IOException {

        paramHttpServletRequest.setAttribute("error", paramString1);
        paramHttpServletRequest.setAttribute("fullName", paramString2);
        paramHttpServletRequest.setAttribute("username", paramString3);
        paramHttpServletRequest.setAttribute("email", paramString4);

        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/register.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }
}