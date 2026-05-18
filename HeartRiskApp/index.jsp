<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CardioAssess - Cardiovascular Risk Assessment</title>
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

<!-- Page Wrapper -->
<div class="page-wrap">
  <!-- Hero Section -->
  <div class="hero">
    <div class="badge"><div class="badge-dot"></div>AI-Powered Clinical Tool</div>
    <h1>Cardiovascular Risk Assessment</h1>
    <p>Enter your health data for an AI-powered cardiac risk evaluation based on clinical guidelines.</p>
  </div>

  <!-- CTA Buttons -->
  <div style="display: flex; gap: 12px; justify-content: center; margin-bottom: 40px; flex-wrap: wrap;">
    <c:choose>
      <c:when test="${empty sessionScope.user}">
        <button class="btn" onclick="location.href='${pageContext.request.contextPath}/register'" style="width: auto; margin-top: 0; padding: 13px 32px; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">♥ Start Assessment</button>
      </c:when>
      <c:otherwise>
        <button class="btn" onclick="location.href='${pageContext.request.contextPath}/dashboard'" style="width: auto; margin-top: 0; padding: 13px 32px; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">📊 Go to Dashboard</button>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Tools Section -->
  <div id="tools">
    <h2 style="font-size: 1.8rem; font-weight: 800; margin-bottom: 28px; text-align: center; background: linear-gradient(135deg, #fff 0%, #ffb3cb 100%); background-clip: text; -webkit-text-fill-color: transparent;">Diagnostic Tools</h2>
    
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 16px; margin-bottom: 40px;">
      <!-- Risk Assessment -->
      <div class="card">
        <div style="font-size: 2rem; margin-bottom: 12px;">📋</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Risk Assessment</h3>
        <p style="font-size: .88rem; color: rgba(255,255,255,.48); line-height: 1.6; margin-bottom: 16px;">Comprehensive cardiovascular risk evaluation based on health indicators</p>
        <c:choose>
          <c:when test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/register" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Get Started →</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/assess" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Start Assessment →</a>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- BMI Calculator -->
      <div class="card">
        <div style="font-size: 2rem; margin-bottom: 12px;">📐</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">BMI Calculator</h3>
        <p style="font-size: .88rem; color: rgba(255,255,255,.48); line-height: 1.6; margin-bottom: 16px;">Calculate your Body Mass Index and health implications</p>
        <a href="${pageContext.request.contextPath}/tools/bmi" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Calculate →</a>
      </div>

      <!-- Blood Pressure -->
      <div class="card">
        <div style="font-size: 2rem; margin-bottom: 12px;">📊</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Blood Pressure Classifier</h3>
        <p style="font-size: .88rem; color: rgba(255,255,255,.48); line-height: 1.6; margin-bottom: 16px;">Check BP reading against medical guidelines</p>
        <a href="${pageContext.request.contextPath}/tools/bp" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Check →</a>
      </div>

      <!-- Heart Age -->
      <div class="card">
        <div style="font-size: 2rem; margin-bottom: 12px;">❤️</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Heart Age Calculator</h3>
        <p style="font-size: .88rem; color: rgba(255,255,255,.48); line-height: 1.6; margin-bottom: 16px;">Discover your heart's biological age</p>
        <a href="${pageContext.request.contextPath}/tools/heart-age" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Calculate →</a>
      </div>

      <!-- Heart Anatomy -->
      <div class="card">
        <div style="font-size: 2rem; margin-bottom: 12px;">🫀</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Heart Anatomy Explorer</h3>
        <p style="font-size: .88rem; color: rgba(255,255,255,.48); line-height: 1.6; margin-bottom: 16px;">Interactive guide to heart structures</p>
        <a href="${pageContext.request.contextPath}/tools/anatomy" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Explore →</a>
      </div>

      <!-- Health Quiz -->
      <div class="card">
        <div style="font-size: 2rem; margin-bottom: 12px;">🧠</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Health Quiz</h3>
        <p style="font-size: .88rem; color: rgba(255,255,255,.48); line-height: 1.6; margin-bottom: 16px;">Test your cardiovascular health knowledge</p>
        <a href="${pageContext.request.contextPath}/tools/quiz" class="btn" style="width: 100%; text-align: center; background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">Take Quiz →</a>
      </div>
    </div>
  </div>

  <!-- Features Section -->
  <div style="margin-top: 60px; padding: 40px; background: rgba(255,60,120,.08); border: 1px solid rgba(255,60,120,.15); border-radius: 18px;">
    <h2 style="font-size: 1.8rem; font-weight: 800; margin-bottom: 28px; text-align: center;">Why CardioAssess?</h2>
    
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 24px;">
      <div style="text-align: center;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">🔬</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Evidence-Based</h3>
        <p style="font-size: .85rem; color: rgba(255,255,255,.48);">Clinically validated algorithms</p>
      </div>
      <div style="text-align: center;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">📈</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Detailed Analytics</h3>
        <p style="font-size: .85rem; color: rgba(255,255,255,.48);">Track metrics over time</p>
      </div>
      <div style="text-align: center;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">🔒</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Secure & Private</h3>
        <p style="font-size: .85rem; color: rgba(255,255,255,.48);">Data encrypted & secure</p>
      </div>
      <div style="text-align: center;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">💡</div>
        <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 8px;">Personalized</h3>
        <p style="font-size: .85rem; color: rgba(255,255,255,.48);">Tailored recommendations</p>
      </div>
    </div>
  </div>
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

function show(id){
  document.getElementById('menuPanel').classList.remove('open');
  setTimeout(()=>document.getElementById(id).classList.add('open'),10);
}
function hide(id){ document.getElementById(id).classList.remove('open'); }
</script>

</body>
</html>
