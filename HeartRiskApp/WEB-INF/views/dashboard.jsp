<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    pageContext.setAttribute("pageTitle", "Dashboard");
    pageContext.setAttribute("navActive", "dashboard");
%>
<jsp:include page="header.jsp"/>

<main class="page-wrap">

  <!-- ── Greeting ──────────────────────────────────────────────────────── -->
  <section class="dash-hero">
    <div>
      <div class="badge">
        <span class="badge-dot"></span> Live Dashboard
      </div>
      <h2>Hello, ${sessionScope.user.fullName.split(' ')[0]} 👋</h2>
      <p>Here's your cardiovascular health overview.</p>
    </div>
    <a href="${pageContext.request.contextPath}/assess" class="btn-primary">
      ♥ &nbsp;New Assessment
    </a>
  </section>

  <!-- ── Stats Row ─────────────────────────────────────────────────────── -->
  <div class="stats-row">
    <div class="stat-card">
      <div class="stat-icon">📊</div>
      <div class="stat-body">
        <span class="stat-value">${totalAssessments}</span>
        <span class="stat-label">Assessments Done</span>
      </div>
    </div>

    <c:choose>
      <c:when test="${not empty latestAssessment}">
        <div class="stat-card">
          <div class="stat-icon">❤️</div>
          <div class="stat-body">
            <span class="stat-value risk-${latestAssessment.riskLevel.toLowerCase().replace(' ','-')}">
              ${latestAssessment.riskPercent}%
            </span>
            <span class="stat-label">Latest Risk Score</span>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">⚖️</div>
          <div class="stat-body">
            <span class="stat-value">${latestAssessment.bmi}</span>
            <span class="stat-label">BMI (${latestAssessment.bmiCategory})</span>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">🩺</div>
          <div class="stat-body">
            <span class="stat-value">${latestAssessment.systolicBp}/${latestAssessment.diastolicBp}</span>
            <span class="stat-label">Last Blood Pressure</span>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <div class="stat-card stat-empty" style="grid-column:span 3">
          <p>No assessments yet. <a href="${pageContext.request.contextPath}/assess">Run your first one →</a></p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- ── Quick Access Tools ────────────────────────────────────────────── -->
  <section class="quick-tools">
    <div class="qt-header">
      <h3>Health Tools & Resources</h3>
      <p>Quick access to calculators and information</p>
    </div>
    <div class="qt-grid">
      <a href="${pageContext.request.contextPath}/tools/bmi" class="qt-card">
        <div class="qt-icon">⚖️</div>
        <div class="qt-content">
          <h4>BMI Calculator</h4>
          <p>Calculate your body mass index</p>
        </div>
        <span class="qt-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/tools/bp" class="qt-card">
        <div class="qt-icon">🩸</div>
        <div class="qt-content">
          <h4>Blood Pressure Classifier</h4>
          <p>Check your BP reading</p>
        </div>
        <span class="qt-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/tools/heart-age" class="qt-card">
        <div class="qt-icon">⏰</div>
        <div class="qt-content">
          <h4>Heart Age Calculator</h4>
          <p>Discover your heart's age</p>
        </div>
        <span class="qt-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/tools/anatomy" class="qt-card">
        <div class="qt-icon">🫀</div>
        <div class="qt-content">
          <h4>Heart Anatomy Explorer</h4>
          <p>Learn heart structures</p>
        </div>
        <span class="qt-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/tools/quiz" class="qt-card">
        <div class="qt-icon">❓</div>
        <div class="qt-content">
          <h4>Health Quiz</h4>
          <p>Test your knowledge</p>
        </div>
        <span class="qt-arrow">→</span>
      </a>
      <a href="${pageContext.request.contextPath}/info/project" class="qt-card">
        <div class="qt-icon">📋</div>
        <div class="qt-content">
          <h4>About This Project</h4>
          <p>Learn more about CardioAssess</p>
        </div>
        <span class="qt-arrow">→</span>
      </a>
    </div>
  </section>

  <!-- ── Latest result card ─────────────────────────────────────────────── -->
  <c:if test="${not empty latestAssessment}">
    <section class="result-preview">
      <div class="rp-header">
        <h3>Latest Assessment</h3>
        <a href="${pageContext.request.contextPath}/history" class="link-muted">View all →</a>
      </div>

      <div class="rp-body">
        <!-- Risk meter -->
        <div class="risk-meter-wrap">
          <div class="risk-level-badge risk-${latestAssessment.riskLevel.toLowerCase().replace(' ','-')}">
            ${latestAssessment.riskLevel} Risk
          </div>
          <div class="risk-bar-bg">
            <div class="risk-bar-fill" style="width:${latestAssessment.riskPercent}%"></div>
          </div>
          <span class="risk-pct">${latestAssessment.riskPercent}%</span>
        </div>

        <!-- Key stats grid -->
        <div class="rp-grid">
          <div class="rp-item"><span class="rp-lbl">Age</span><span class="rp-val">${latestAssessment.age} yrs</span></div>
          <div class="rp-item"><span class="rp-lbl">Gender</span><span class="rp-val">${latestAssessment.genderLabel}</span></div>
          <div class="rp-item"><span class="rp-lbl">BMI</span><span class="rp-val">${latestAssessment.bmi}</span></div>
          <div class="rp-item"><span class="rp-lbl">Cholesterol</span><span class="rp-val">${latestAssessment.cholesterolLabel}</span></div>
          <div class="rp-item"><span class="rp-lbl">Glucose</span><span class="rp-val">${latestAssessment.glucoseLabel}</span></div>
          <div class="rp-item"><span class="rp-lbl">Smoking</span><span class="rp-val">${latestAssessment.smokingLabel}</span></div>
          <div class="rp-item"><span class="rp-lbl">Activity</span><span class="rp-val">${latestAssessment.activeLabel}</span></div>
          <div class="rp-item">
            <span class="rp-lbl">Date</span>
            <span class="rp-val">
              <fmt:formatDate value="${latestAssessment.assessedAt}" pattern="dd MMM yyyy"/>
            </span>
          </div>
        </div>
      </div>
    </section>
  </c:if>

</main>

