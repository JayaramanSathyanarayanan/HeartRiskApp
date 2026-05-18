<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "Blood Pressure Classifier"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<!-- Page Content -->
<div class="page-wrap">
  <div class="card" style="max-width: 500px; margin: 40px auto;">
    <div style="text-align: center; margin-bottom: 28px;">
      <div style="font-size: 2.5rem; margin-bottom: 12px;">📊</div>
      <h1 style="font-size: 1.8rem; font-weight: 800; background: linear-gradient(135deg, #ff3c78, #ff8c00); background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 6px;">Blood Pressure</h1>
      <p style="font-size: .88rem; color: rgba(255,255,255,.48);">Classify your blood pressure reading</p>
    </div>

    <div style="font-size: .85rem; color: rgba(255,255,255,.6); margin-bottom: 20px; padding: 10px; background: rgba(255,140,0,.1); border-radius: 8px; border-left: 3px solid #ff8c00;">
      <strong>Reference:</strong> Normal &lt;120/80 | Elevated 120-129/&lt;80 | Stage 1 130-139/80-89 | Stage 2 ≥140/≥90
    </div>

    <div class="fg" style="margin-bottom: 16px;">
      <label for="systolic">Systolic BP (mmHg)</label>
      <input type="number" id="systolic" placeholder="e.g. 120" min="70" max="250">
    </div>

    <div class="fg" style="margin-bottom: 16px;">
      <label for="diastolic">Diastolic BP (mmHg)</label>
      <input type="number" id="diastolic" placeholder="e.g. 80" min="40" max="150">
    </div>

    <button class="btn" onclick="classifyBP()" style="background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">📈 Classify BP</button>

    <div id="result" style="display: none; margin-top: 30px; padding: 24px; border-radius: 11px; text-align: center; animation: slideIn .3s ease;">
      <div id="bpReading" style="font-size: 1.5rem; font-weight: 700; margin-bottom: 12px;">--</div>
      <div id="bpCategory" style="font-size: 1.2rem; font-weight: 600; margin: 10px 0;">--</div>
      <div id="bpAdvice" style="margin-top: 15px; font-size: .95rem; line-height: 1.6; color: rgba(255,255,255,.6);"></div>
    </div>

    <a href="${pageContext.request.contextPath}/" class="back-btn" style="display: block; text-align: center; margin-top: 20px;">← Back to Home</a>
  </div>
</div>

<style>
@keyframes slideIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
#result.normal { background: rgba(16,185,129,.15); border: 1px solid rgba(16,185,129,.4); }
#result.elevated { background: rgba(234,179,8,.15); border: 1px solid rgba(234,179,8,.4); }
#result.stage1 { background: rgba(249,115,22,.15); border: 1px solid rgba(249,115,22,.4); }
#result.stage2 { background: rgba(239,68,68,.15); border: 1px solid rgba(239,68,68,.4); }
#result.normal .bpText { color: #10b981; }
#result.elevated .bpText { color: #eab308; }
#result.stage1 .bpText { color: #f97316; }
#result.stage2 .bpText { color: #ef4444; }
</style>

<script>
function classifyBP() {
    const systolic = parseFloat(document.getElementById('systolic').value);
    const diastolic = parseFloat(document.getElementById('diastolic').value);
    
    if (!systolic || !diastolic) {
        alert('Please enter both systolic and diastolic values');
        return;
    }
    
    const resultDiv = document.getElementById('result');
    const bpReading = document.getElementById('bpReading');
    const bpCategory = document.getElementById('bpCategory');
    const bpAdvice = document.getElementById('bpAdvice');
    
    bpReading.textContent = systolic + '/' + diastolic;
    resultDiv.className = '';
    
    let category = '';
    let advice = '';
    
    if (systolic < 120 && diastolic < 80) {
        category = 'Normal';
        advice = 'Great! Continue maintaining healthy blood pressure. Regular exercise and balanced diet help.';
        resultDiv.className = 'normal bpText';
    } else if (systolic <= 129 && diastolic < 80) {
        category = 'Elevated';
        advice = 'Your BP is slightly elevated. Focus on lifestyle modifications and regular monitoring.';
        resultDiv.className = 'elevated bpText';
    } else if ((systolic >= 130 && systolic <= 139) || (diastolic >= 80 && diastolic <= 89)) {
        category = 'High Blood Pressure (Stage 1)';
        advice = 'Consult your doctor for monitoring and treatment options.';
        resultDiv.className = 'stage1 bpText';
    } else if (systolic >= 140 || diastolic >= 90) {
        category = 'High Blood Pressure (Stage 2)';
        advice = 'Seek medical consultation immediately for evaluation and treatment.';
        resultDiv.className = 'stage2 bpText';
    }
    
    bpCategory.textContent = category;
    bpAdvice.textContent = advice;
    resultDiv.style.display = 'block';
}

document.getElementById('systolic').addEventListener('keypress', e => e.key === 'Enter' && classifyBP());
document.getElementById('diastolic').addEventListener('keypress', e => e.key === 'Enter' && classifyBP());
</script>

