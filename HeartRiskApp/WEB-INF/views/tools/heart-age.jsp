<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Heart Age Calculator"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<!-- Page Content -->
<div class="page-wrap">
  <div class="card" style="max-width: 500px; margin: 40px auto;">
    <div style="text-align: center; margin-bottom: 28px;">
      <div style="font-size: 2.5rem; margin-bottom: 12px;">❤️</div>
      <h1 style="font-size: 1.8rem; font-weight: 800; background: linear-gradient(135deg, #ff3c78, #ff8c00); background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 6px;">Heart Age Calculator</h1>
      <p style="font-size: .88rem; color: rgba(255,255,255,.48);">Discover your heart's biological age</p>
    </div>

    <div class="grid">
      <div class="fg">
        <label for="age">Chronological Age</label>
        <input type="number" id="age" placeholder="e.g. 45" min="18" max="100">
      </div>
      <div class="fg">
        <label for="smoking">Smoking Status</label>
        <select id="smoking">
          <option value="0">Non-Smoker</option>
          <option value="1">Smoker</option>
        </select>
      </div>
      <div class="fg">
        <label for="activity">Activity Level</label>
        <select id="activity">
          <option value="1">Active</option>
          <option value="0">Sedentary</option>
        </select>
      </div>
      <div class="fg">
        <label for="systolic">Systolic BP (mmHg)</label>
        <input type="number" id="systolic" placeholder="e.g. 120" min="70" max="250">
      </div>
    </div>

    <button class="btn" onclick="calculateHeartAge()" style="background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">💓 Calculate Heart Age</button>

    <div id="result" style="display: none; margin-top: 30px; padding: 24px; background: rgba(255,140,0,.1); border: 1px solid rgba(255,140,0,.3); border-radius: 11px; text-align: center; animation: slideIn .3s ease;">
      <div id="heartAge" style="font-size: 2.5rem; font-weight: 800; color: #ffd280; margin: 20px 0;">--</div>
      <div id="ageDiff" style="font-size: 1.1rem; margin-bottom: 15px;">--</div>
      <div id="suggestion" style="margin-top: 15px; font-size: .95rem; line-height: 1.6; color: rgba(255,255,255,.6);"></div>
    </div>

    <a href="${pageContext.request.contextPath}/" class="back-btn" style="display: block; text-align: center; margin-top: 20px;">← Back to Home</a>
  </div>
</div>

<style>
@keyframes slideIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
#ageDiff.positive { color: #22c55e !important; }
#ageDiff.negative { color: #ef4444 !important; }
select { appearance: none; background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e"); background-repeat: no-repeat; background-position: right 12px center; background-size: 1.5em 1.5em; padding-right: 40px; }
</style>

<script>
function calculateHeartAge() {
    const age = parseFloat(document.getElementById('age').value);
    const smoking = parseFloat(document.getElementById('smoking').value);
    const activity = parseFloat(document.getElementById('activity').value);
    const systolic = parseFloat(document.getElementById('systolic').value) || 120;
    
    if (!age || age < 18 || age > 100) {
        alert('Please enter a valid age (18-100)');
        return;
    }
    
    let heartAge = age;
    
    // Smoking adds 5 years
    if (smoking === 1) heartAge += 5;
    
    // Sedentary lifestyle adds 3 years
    if (activity === 0) heartAge += 3;
    
    // High systolic BP adds years
    if (systolic > 130) {
        heartAge += Math.round((systolic - 130) / 10) * 2;
    }
    
    const resultDiv = document.getElementById('result');
    const heartAgeDiv = document.getElementById('heartAge');
    const ageDiffDiv = document.getElementById('ageDiff');
    const suggestionDiv = document.getElementById('suggestion');
    
    heartAgeDiv.textContent = Math.round(heartAge);
    
    const diff = Math.round(heartAge) - age;
    if (diff > 0) {
        ageDiffDiv.className = 'negative';
        ageDiffDiv.textContent = '⚠️ Your heart is ' + diff + ' years OLDER than your actual age';
        suggestionDiv.textContent = 'Focus on lifestyle improvements: quit smoking, exercise regularly, and manage blood pressure.';
    } else if (diff < 0) {
        ageDiffDiv.className = 'positive';
        ageDiffDiv.textContent = '✓ Your heart is ' + Math.abs(diff) + ' years YOUNGER than your actual age';
        suggestionDiv.textContent = 'Excellent! Keep maintaining your healthy lifestyle and regular check-ups.';
    } else {
        ageDiffDiv.className = 'positive';
        ageDiffDiv.textContent = '✓ Your heart age matches your actual age';
        suggestionDiv.textContent = 'Good! Continue with healthy habits for optimal cardiovascular health.';
    }
    
    resultDiv.style.display = 'block';
}

document.getElementById('age').addEventListener('keypress', e => e.key === 'Enter' && calculateHeartAge());
</script>

