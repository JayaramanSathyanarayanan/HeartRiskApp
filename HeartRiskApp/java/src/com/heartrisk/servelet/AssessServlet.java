package com.heartrisk.servlet;

import com.heartrisk.dao.AssessmentDAO;
import com.heartrisk.model.Assessment;
import com.heartrisk.model.User;
import com.heartrisk.servlet.DashboardServlet;
import com.heartrisk.util.RiskEngine;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class AssessServlet extends HttpServlet {

    private final AssessmentDAO dao = new AssessmentDAO();

    protected void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {
        if (DashboardServlet.getUser(paramHttpServletRequest, paramHttpServletResponse) == null)
            return;
        paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/assess.jsp")
                .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
    }

    protected void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException {

        User user = DashboardServlet.getUser(paramHttpServletRequest, paramHttpServletResponse);
        if (user == null) {
            return;
        }

        boolean bool = ("application/json".equals(paramHttpServletRequest.getHeader("Accept")) ||
                "XMLHttpRequest".equals(paramHttpServletRequest.getHeader("X-Requested-With")));

        try {
            int i = Integer.parseInt(paramHttpServletRequest.getParameter("age"));
            int j = Integer.parseInt(paramHttpServletRequest.getParameter("gender"));
            double d1 = Double.parseDouble(paramHttpServletRequest.getParameter("height"));
            double d2 = Double.parseDouble(paramHttpServletRequest.getParameter("weight"));
            int k = Integer.parseInt(paramHttpServletRequest.getParameter("ap_hi"));
            int m = Integer.parseInt(paramHttpServletRequest.getParameter("ap_lo"));
            int n = Integer.parseInt(paramHttpServletRequest.getParameter("cholesterol"));
            int i1 = Integer.parseInt(paramHttpServletRequest.getParameter("gluc"));
            int i2 = Integer.parseInt(paramHttpServletRequest.getParameter("smoking"));
            int i3 = Integer.parseInt(paramHttpServletRequest.getParameter("alco"));
            int i4 = Integer.parseInt(paramHttpServletRequest.getParameter("active"));

            double d3 = d2 / Math.pow(d1 / 100.0D, 2.0D);

            double d4 = RiskEngine.predict(i, j, d1, d2, k, m, n, i1, i2, i3, i4);

            String str = RiskEngine.riskLevel(d4);

            Assessment assessment = new Assessment();
            assessment.setUserId(user.getId());
            assessment.setAge(i);
            assessment.setGender(j);
            assessment.setHeightCm(d1);
            assessment.setWeightKg(d2);
            assessment.setBmi(Math.round(d3 * 10.0D) / 10.0D);
            assessment.setSystolicBp(k);
            assessment.setDiastolicBp(m);
            assessment.setCholesterol(n);
            assessment.setGlucose(i1);
            assessment.setSmoking(i2);
            assessment.setAlcohol(i3);
            assessment.setActive(i4);
            assessment.setRiskScore(Math.round(d4 * 10000.0D) / 10000.0D);
            assessment.setRiskLevel(str);

            int i5 = this.dao.save(assessment);
            assessment.setId(i5);

            if (bool) {

                String str1 = escapeJson(buildTips(assessment));
                String str2 = String.format(
                        "{\"riskScore\":%.4f,\"riskPercent\":%d,\"riskLevel\":\"%s\",\"bmi\":%.1f,\"bmiCategory\":\"%s\",\"tips\":\"%s\",\"assessmentId\":%d}",
                        assessment.getRiskScore(),
                        assessment.getRiskPercent(),
                        escapeJson(str),
                        assessment.getBmi(),
                        escapeJson(assessment.getBmiCategory()),
                        str1,
                        i5
                );

                paramHttpServletResponse.setContentType("application/json;charset=UTF-8");
                PrintWriter printWriter = paramHttpServletResponse.getWriter();
                printWriter.print(str2);
                printWriter.flush();

            } else {

                HttpSession httpSession = paramHttpServletRequest.getSession();
                httpSession.setAttribute("lastAssessment", assessment);
                paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getContextPath() + "/assess?result=1");
            }

        } catch (NumberFormatException numberFormatException) {

            if (bool) {
                paramHttpServletResponse.setStatus(400);
                paramHttpServletResponse.setContentType("application/json;charset=UTF-8");
                paramHttpServletResponse.getWriter().print("{\"error\":\"Invalid input values.\"}");
            } else {
                paramHttpServletRequest.setAttribute("error", "Please fill in all fields correctly.");
                paramHttpServletRequest.getRequestDispatcher("/WEB-INF/views/assess.jsp")
                        .forward((ServletRequest) paramHttpServletRequest, (ServletResponse) paramHttpServletResponse);
            }
        }
    }

    private String escapeJson(String paramString) {
        if (paramString == null) return "";
        return paramString
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private String buildTips(Assessment paramAssessment) {
        StringBuilder stringBuilder = new StringBuilder();

        if (paramAssessment.getRiskScore() >= 0.75D) {
            stringBuilder.append("Very high risk detected. Please consult a cardiologist urgently.\n");
        } else if (paramAssessment.getRiskScore() >= 0.5D) {
            stringBuilder.append("High risk. Schedule a cardiac check-up soon.\n");
        } else if (paramAssessment.getRiskScore() >= 0.25D) {
            stringBuilder.append("Moderate risk. Lifestyle changes can significantly reduce your risk.\n");
        } else {
            stringBuilder.append("Low risk. Keep up your healthy habits!\n");
        }

        if (paramAssessment.getSystolicBp() >= 140)
            stringBuilder.append("• Manage blood pressure through diet and medication if needed.\n");

        if (paramAssessment.getCholesterol() == 3)
            stringBuilder.append("• High cholesterol detected — reduce saturated fats.\n");

        if (paramAssessment.getSmoking() == 1)
            stringBuilder.append("• Quit smoking to dramatically lower heart disease risk.\n");

        if (paramAssessment.getBmi() >= 30.0D)
            stringBuilder.append("• Weight management can reduce cardiac load.\n");

        if (paramAssessment.getActive() == 0)
            stringBuilder.append("• Aim for 150 min of moderate exercise per week.\n");

        if (paramAssessment.getGlucose() == 3)
            stringBuilder.append("• High glucose may indicate diabetes — monitor blood sugar.\n");

        if (paramAssessment.getAlcohol() == 1)
            stringBuilder.append("• Reduce alcohol intake for better heart health.\n");

        return stringBuilder.toString().trim();
    }
}