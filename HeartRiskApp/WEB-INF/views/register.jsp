<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("pageTitle", "Create Account");
%>
<jsp:include page="header.jsp"/>

<div class="page-wrap">
  <div class="card" style="max-width: 500px; margin: 60px auto;">
    <div style="text-align: center; margin-bottom: 28px;">
      <div style="width: 56px; height: 56px; border-radius: 14px; margin: 0 auto 14px; background: linear-gradient(135deg, #ff3c78, #ff8c00); display: grid; place-items: center; font-size: 22px; box-shadow: 0 8px 28px rgba(255,60,120,.5);">♥</div>
      <h1 style="font-size: 1.55rem; font-weight: 800; background: linear-gradient(135deg, #fff 0%, #ffb3cb 100%); background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 6px;">Create Account</h1>
      <p style="font-size: .85rem; color: rgba(255,255,255,.48);">Join CardioAssess for personalized heart risk tracking</p>
    </div>

    <c:if test="${not empty error}">
      <div style="padding: 11px 16px; border-radius: 9px; margin-bottom: 16px; font-size: .86rem; background: rgba(239,68,68,.15); border: 1px solid rgba(239,68,68,.35); color: #fca5a5;">⚠ ${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
      <div class="grid">
        <div class="fg">
          <label for="fullName">Full Name</label>
          <input type="text" id="fullName" name="fullName"
                 value="${not empty fullName ? fullName : ''}"
                 placeholder="Jane Smith" required>
        </div>
        <div class="fg">
          <label for="username">Username</label>
          <input type="text" id="username" name="username"
                 value="${not empty username ? username : ''}"
                 placeholder="janesmith" required minlength="3">
        </div>
        <div class="fg" style="grid-column: 1/-1;">
          <label for="email">Email Address</label>
          <input type="email" id="email" name="email"
                 value="${not empty email ? email : ''}"
                 placeholder="jane@example.com" required>
        </div>
        <div class="fg">
          <label for="password">Password</label>
          <input type="password" id="password" name="password"
                 placeholder="Min. 6 characters" required minlength="6">
        </div>
        <div class="fg">
          <label for="confirmPassword">Confirm Password</label>
          <input type="password" id="confirmPassword" name="confirmPassword"
                 placeholder="Repeat password" required>
        </div>
      </div>

      <button type="submit" class="btn" style="background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none; box-shadow: 0 8px 26px rgba(255,60,120,.45);">♥ Create Account</button>
    </form>

    <p style="text-align: center; margin-top: 20px; font-size: .84rem; color: rgba(255,255,255,.48);">
      Already have an account?
      <a href="${pageContext.request.contextPath}/login" style="color: #ff3c78; text-decoration: none; font-weight: 600;">Sign in</a>
    </p>
  </div>
</div>


