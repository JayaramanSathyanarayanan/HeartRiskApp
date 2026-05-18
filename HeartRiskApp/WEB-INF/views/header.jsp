<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CardioAssess — ${pageTitle}</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-theme.css">
</head>
<body>

<!-- Floating hearts decoration -->
<div class="hf" style="left:7%;top:30%">♥</div>
<div class="hf" style="left:88%;top:22%;animation-delay:2.5s">♥</div>
<div class="hf" style="left:5%;top:70%;animation-delay:5s">♥</div>
<div class="hf" style="left:91%;top:65%;animation-delay:1.5s">♥</div>

<!-- Navbar -->
<nav>
  <div class="brand">
    <div class="brand-icon">♥</div>
    <div class="brand-name">Cardio<span>Assess</span></div>
  </div>
  <span id="clock">00:00:00</span>
</nav>

<!-- Menu Button & Panel -->
<button id="menuBtn" onclick="toggleMenu(event)">☰ &nbsp;Menu</button>
<div id="menuPanel">
  <button onclick="location.href='${pageContext.request.contextPath}/'">🏠 Home</button>
  <c:if test="${empty sessionScope.user}">
    <button onclick="location.href='${pageContext.request.contextPath}/login'">🔐 Sign In</button>
    <button onclick="location.href='${pageContext.request.contextPath}/register'">📝 Register</button>
  </c:if>
  <c:if test="${not empty sessionScope.user}">
    <button onclick="location.href='${pageContext.request.contextPath}/dashboard'">📊 Dashboard</button>
    <button onclick="location.href='${pageContext.request.contextPath}/assess'">➕ New Assessment</button>
    <button onclick="location.href='${pageContext.request.contextPath}/history'">📋 History</button>
  </c:if>
  <hr style="border:none;height:1px;background:rgba(255,255,255,.1);margin:4px 0">
  <button onclick="location.href='${pageContext.request.contextPath}/tools/bmi'">📐 BMI Calculator</button>
  <button onclick="location.href='${pageContext.request.contextPath}/tools/bp'">📊 Blood Pressure</button>
  <button onclick="location.href='${pageContext.request.contextPath}/tools/heart-age'">❤️ Heart Age</button>
  <button onclick="location.href='${pageContext.request.contextPath}/tools/anatomy'">🫀 Anatomy Explorer</button>
  <button onclick="location.href='${pageContext.request.contextPath}/tools/quiz'">🧠 Health Quiz</button>
  <button onclick="location.href='${pageContext.request.contextPath}/info/project'">📋 Project Info</button>
  <button onclick="location.href='${pageContext.request.contextPath}/info/developers'">👥 Developers</button>
  <c:if test="${not empty sessionScope.user}">
    <hr style="border:none;height:1px;background:rgba(255,255,255,.1);margin:4px 0">
    <button onclick="location.href='${pageContext.request.contextPath}/logout'">🚪 Sign Out</button>
  </c:if>
</div>

<script>
setInterval(()=>{
  const n=new Date();
  document.getElementById('clock').textContent=
    [n.getHours(),n.getMinutes(),n.getSeconds()].map(v=>('0'+v).slice(-2)).join(':');
},1000);

function toggleMenu(e){
  e.stopPropagation();
  document.getElementById('menuPanel').classList.toggle('open');
}
document.addEventListener('click',e=>{
  if(!e.target.closest('#menuPanel')&&!e.target.closest('#menuBtn'))
    document.getElementById('menuPanel').classList.remove('open');
});
</script>
