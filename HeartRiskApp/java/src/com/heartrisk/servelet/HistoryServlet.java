package com.heartrisk.servlet;

import com.heartrisk.dao.AssessmentDAO;
import com.heartrisk.model.User;
import com.heartrisk.servlet.DashboardServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HistoryServlet extends HttpServlet {

    private final AssessmentDAO dao = new AssessmentDAO();

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        User user = DashboardServlet.getUser(paramHttpServletRequest, paramHttpServletResponse);
        if (user == null)
            return;

        paramHttpServletRequest.setAttribute("assessments", this.dao.findByUser(user.getId()));

        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/history.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }
}