<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("pageTitle", "Sign In");
%>
<jsp:include page="header.jsp"/>

<div class="page-wrap">
  <div class="card" style="max-width: 450px; margin: 80px auto;">
    <div style="text-align: center; margin-bottom: 28px;">
      <div style="width: 56px; height: 56px; border-radius: 14px; margin: 0 auto 14px; background: linear-gradient(135deg, #ff3c78, #ff8c00); display: grid; place-items: center; font-size: 22px; box-shadow: 0 8px 28px rgba(255,60,120,.5);">♥</div>
      <h1 style="font-size: 1.55rem; font-weight: 800; background: linear-gradient(135deg, #fff 0%, #ffb3cb 100%); background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 6px;">Welcome Back</h1>
      <p style="font-size: .85rem; color: rgba(255,255,255,.48);">Sign in to your CardioAssess account</p>
    </div>

    <c:if test="${param.registered == '1'}">
      <div style="padding: 11px 16px; border-radius: 9px; margin-bottom: 16px; font-size: .86rem; background: rgba(34,197,94,.15); border: 1px solid rgba(34,197,94,.35); color: #86efac;">✓ Account created! You can now sign in.</div>
    </c:if>
    <c:if test="${param.logout == '1'}">
      <div style="padding: 11px 16px; border-radius: 9px; margin-bottom: 16px; font-size: .86rem; background: rgba(34,197,94,.15); border: 1px solid rgba(34,197,94,.35); color: #86efac;">✓ You have been signed out.</div>
    </c:if>
    <c:if test="${not empty error}">
      <div style="padding: 11px 16px; border-radius: 9px; margin-bottom: 16px; font-size: .86rem; background: rgba(239,68,68,.15); border: 1px solid rgba(239,68,68,.35); color: #fca5a5;">⚠ ${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
      <div class="fg">
        <label for="username">Username</label>
        <input type="text" id="username" name="username"
               value="${not empty rememberedUser ? rememberedUser : ''}"
               placeholder="your_username" required autocomplete="username">
      </div>
      <div class="fg" style="margin-top: 14px;">
        <label for="password">Password</label>
        <input type="password" id="password" name="password"
               placeholder="••••••••" required autocomplete="current-password">
      </div>
      <div style="display: flex; align-items: center; margin-top: 14px;">
        <label style="display: flex; align-items: center; gap: 8px; font-size: .84rem; color: rgba(255,255,255,.48); cursor: pointer; text-transform: none; letter-spacing: 0;">
          <input type="checkbox" name="rememberMe"
                 ${not empty rememberedUser ? 'checked' : ''} style="width: 16px; height: 16px; padding: 0; border-radius: 4px; cursor: pointer; accent-color: #ff3c78;">
          Remember me
        </label>
      </div>
      <button type="submit" class="btn" style="background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none; box-shadow: 0 8px 26px rgba(255,60,120,.45);">♥ Sign In</button>
    </form>

    <p style="text-align: center; margin-top: 20px; font-size: .84rem; color: rgba(255,255,255,.48);">
      Don't have an account?
      <a href="${pageContext.request.contextPath}/register" style="color: #ff3c78; text-decoration: none; font-weight: 600;">Create one</a>
    </p>

    
  </div>
</div>


