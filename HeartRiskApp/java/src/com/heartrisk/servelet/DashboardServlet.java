package com.heartrisk.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.heartrisk.dao.AssessmentDAO;
import com.heartrisk.model.Assessment;
import com.heartrisk.model.User;

public class DashboardServlet extends HttpServlet {

    private final AssessmentDAO dao = new AssessmentDAO();

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {
        User user = getUser(paramHttpServletRequest, paramHttpServletResponse);
        if (user == null)
            return;

        Assessment assessment = this.dao.findLatest(user.getId());
        int i = this.dao.countByUser(user.getId());

        paramHttpServletRequest.setAttribute("latestAssessment", assessment);
        paramHttpServletRequest.setAttribute("totalAssessments", Integer.valueOf(i));

        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/dashboard.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }

    static User getUser(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws IOException {
        HttpSession httpSession = paramHttpServletRequest.getSession(false);

        if (httpSession == null || httpSession.getAttribute("user") == null) {
            paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/login");
            return null;
        }

        return (User) httpSession.getAttribute("user");
    }
}