<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    pageContext.setAttribute("pageTitle", "Assessment History");
    pageContext.setAttribute("navActive", "history");
%>
<jsp:include page="header.jsp"/>

<style>
  .table-wrap {
    margin-top: 24px;
    border-radius: 12px;
    background: rgba(255,255,255,.04);
    border: 1px solid rgba(255,255,255,.08);
  }

  .hist-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.85rem;
    table-layout: auto;
  }

  .hist-table thead {
    background: rgba(255,60,120,.1);
    border-bottom: 2px solid rgba(255,60,120,.2);
  }

  .hist-table th {
    padding: 10px 8px;
    text-align: left;
    font-weight: 700;
    color: #fff;
    white-space: nowrap;
    font-size: 0.8rem;
    letter-spacing: 0.3px;
  }

  .hist-table td {
    padding: 9px 7px;
    border-bottom: 1px solid rgba(255,255,255,.05);
    color: rgba(255,255,255,.8);
  }

  .hist-table tbody tr:hover {
    background: rgba(255,60,120,.05);
  }

  .hist-table tbody tr:last-child td {
    border-bottom: none;
  }

  .td-num {
    font-weight: 600;
    color: rgba(255,60,120,.8);
    width: 30px;
    text-align: center;
  }

  .td-date {
    font-weight: 500;
    width: 75px;
  }

  .small-muted {
    display: block;
    font-size: 0.7rem;
    color: rgba(255,255,255,.5);
  }

  .mini-bar-bg {
    width: 50px;
    height: 5px;
    background: rgba(255,255,255,.1);
    border-radius: 2px;
    overflow: hidden;
    margin-bottom: 3px;
  }

  .mini-bar-fill {
    height: 100%;
    border-radius: 2px;
    transition: width 0.3s ease;
  }

  .risk-fill-low {
    background: linear-gradient(90deg, #00aa44, #00dd55);
  }

  .risk-fill-moderate {
    background: linear-gradient(90deg, #ffaa00, #ffcc00);
  }

  .risk-fill-high {
    background: linear-gradient(90deg, #ff6600, #ff8800);
  }

  .risk-fill-very-high {
    background: linear-gradient(90deg, #ff2222, #ff5555);
  }

  .pct-label {
    font-size: 0.75rem;
    font-weight: 600;
    color: rgba(255,255,255,.9);
  }

  .risk-badge {
    display: inline-block;
    padding: 3px 8px;
    border-radius: 4px;
    font-size: 0.75rem;
    font-weight: 600;
    letter-spacing: 0.2px;
  }

  .risk-low {
    background: rgba(0,200,100,.15);
    color: #00dd55;
    border: 1px solid rgba(0,200,100,.3);
  }

  .risk-moderate {
    background: rgba(255,170,0,.15);
    color: #ffcc00;
    border: 1px solid rgba(255,170,0,.3);
  }

  .risk-high {
    background: rgba(255,100,0,.15);
    color: #ff8800;
    border: 1px solid rgba(255,100,0,.3);
  }

  .risk-very-high {
    background: rgba(255,50,50,.15);
    color: #ff5555;
    border: 1px solid rgba(255,50,50,.3);
  }

  @media(max-width: 768px) {
    .hist-table {
      font-size: 0.75rem;
    }

    .hist-table th,
    .hist-table td {
      padding: 8px 5px;
    }
  }
</style>

<main class="page-wrap">

  <div class="page-header">
    <div>
      <h2>Assessment History</h2>
      <p>All your past cardiovascular risk assessments</p>
    </div>
    <a href="${pageContext.request.contextPath}/assess" class="btn-primary">+ New Assessment</a>
  </div>

  <c:choose>
    <c:when test="${empty assessments}">
      <div class="empty-state">
        <div class="empty-icon">🫀</div>
        <h3>No assessments yet</h3>
        <p>Run your first assessment to start tracking your heart health.</p>
        <a href="${pageContext.request.contextPath}/assess" class="btn-primary">Get Started</a>
      </div>
    </c:when>

    <c:otherwise>
      <!-- ── Summary chips ──────────────────────────────────────────────── -->
      <div class="hist-summary">
        <span class="chip">Total: <strong>${assessments.size()}</strong></span>

        <%-- Count risk levels using JSTL --%>
        <c:set var="cntLow"      value="0"/>
        <c:set var="cntMod"      value="0"/>
        <c:set var="cntHigh"     value="0"/>
        <c:set var="cntVeryHigh" value="0"/>
        <c:forEach var="a" items="${assessments}">
          <c:choose>
            <c:when test="${a.riskLevel == 'Low'}">       <c:set var="cntLow"      value="${cntLow + 1}"/></c:when>
            <c:when test="${a.riskLevel == 'Moderate'}">  <c:set var="cntMod"      value="${cntMod + 1}"/></c:when>
            <c:when test="${a.riskLevel == 'High'}">      <c:set var="cntHigh"     value="${cntHigh + 1}"/></c:when>
            <c:otherwise>                                 <c:set var="cntVeryHigh" value="${cntVeryHigh + 1}"/></c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${cntLow > 0}">      <span class="chip chip-low">Low: <strong>${cntLow}</strong></span></c:if>
        <c:if test="${cntMod > 0}">      <span class="chip chip-mod">Moderate: <strong>${cntMod}</strong></span></c:if>
        <c:if test="${cntHigh > 0}">     <span class="chip chip-high">High: <strong>${cntHigh}</strong></span></c:if>
        <c:if test="${cntVeryHigh > 0}"> <span class="chip chip-vhigh">Very High: <strong>${cntVeryHigh}</strong></span></c:if>
      </div>

      <!-- ── Table ──────────────────────────────────────────────────────── -->
      <div class="table-wrap">
        <table class="hist-table">
          <thead>
            <tr>
              <th>#</th>
              <th>Date</th>
              <th>Age</th>
              <th>Gender</th>
              <th>BMI</th>
              <th>BP</th>
              <th>Cholesterol</th>
              <th>Glucose</th>
              <th>Smoking</th>
              <th>Risk Score</th>
              <th>Level</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="a" items="${assessments}" varStatus="loop">
              <tr>
                <td class="td-num">${loop.index + 1}</td>
                <td class="td-date">
                  <fmt:formatDate value="${a.assessedAt}" pattern="dd MMM yy"/>
                </td>
                <td>${a.age}</td>
                <td>${a.genderLabel}</td>
                <td>
                  ${a.bmi}
                  <span class="small-muted">${a.bmiCategory}</span>
                </td>
                <td>${a.systolicBp}/${a.diastolicBp}</td>
                <td>${a.cholesterolLabel}</td>
                <td>${a.glucoseLabel}</td>
                <td>${a.smokingLabel}</td>
                <td>
                  <div class="mini-bar-bg">
                    <div class="mini-bar-fill risk-fill-${a.riskLevel.toLowerCase().replace(' ','-')}"
                         style="width:${a.riskPercent}%"></div>
                  </div>
                  <span class="pct-label">${a.riskPercent}%</span>
                </td>
                <td>
                  <span class="risk-badge risk-${a.riskLevel.toLowerCase().replace(' ','-')}">
                    ${a.riskLevel}
                  </span>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>

</main>


