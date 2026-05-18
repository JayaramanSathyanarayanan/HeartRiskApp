<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setAttribute("pageTitle", "BMI Calculator"); %>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<!-- Page Content -->
<div class="page-wrap">
  <div class="card" style="max-width: 500px; margin: 40px auto;">
    <div style="text-align: center; margin-bottom: 28px;">
      <div style="font-size: 2.5rem; margin-bottom: 12px;">📐</div>
      <h1 style="font-size: 1.8rem; font-weight: 800; background: linear-gradient(135deg, #ff3c78, #ff8c00); background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 6px;">BMI Calculator</h1>
      <p style="font-size: .88rem; color: rgba(255,255,255,.48);">Calculate your Body Mass Index</p>
    </div>

    <div class="fg" style="margin-bottom: 16px;">
      <label for="height">Height (cm)</label>
      <input type="number" id="height" placeholder="Enter your height" min="50" max="250" step="0.1">
    </div>

    <div class="fg" style="margin-bottom: 16px;">
      <label for="weight">Weight (kg)</label>
      <input type="number" id="weight" placeholder="Enter your weight" min="20" max="200" step="0.1">
    </div>

    <button class="btn" onclick="calculateBMI()" style="background: linear-gradient(135deg, #ff3c78, #ff8c00); animation: none;">📊 Calculate BMI</button>

    <div id="result" style="display: none; margin-top: 30px; padding: 24px; background: rgba(255,140,0,.1); border: 1px solid rgba(255,140,0,.3); border-radius: 11px; text-align: center; animation: slideIn .3s ease;">
      <div id="bmiValue" style="font-size: 2.5rem; font-weight: 800; color: #ffd280; margin: 20px 0;">--</div>
      <div id="bmiCategory" style="font-size: 1.2rem; font-weight: 600; margin: 10px 0;">--</div>
      <div id="suggestion" style="margin-top: 15px; font-size: .95rem; line-height: 1.6; color: rgba(255,255,255,.6);"></div>
    </div>

    <a href="${pageContext.request.contextPath}/" class="back-btn" style="display: block; text-align: center; margin-top: 20px;">← Back to Home</a>
  </div>
</div>

<style>
@keyframes slideIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
.bmi-category.normal { color: #22c55e; }
.bmi-category.overweight { color: #f59e0b; }
.bmi-category.obese { color: #ef4444; }
.bmi-category.underweight { color: #60a5fa; }
</style>

<script>
function calculateBMI() {
    const height = parseFloat(document.getElementById('height').value);
    const weight = parseFloat(document.getElementById('weight').value);
    if (!height || !weight || height <= 0 || weight <= 0) {
        alert('Please enter valid height and weight values');
        return;
    }
    const heightM = height / 100;
    const bmi = weight / (heightM * heightM);
    const resultDiv = document.getElementById('result');
    const bmiValue = document.getElementById('bmiValue');
    const bmiCategory = document.getElementById('bmiCategory');
    const suggestion = document.getElementById('suggestion');
    bmiValue.textContent = bmi.toFixed(1);
    let category = '';
    let suggestion_text = '';
    if (bmi < 18.5) {
        category = 'Underweight';
        bmiCategory.className = 'bmi-category underweight';
        suggestion_text = 'Consider consulting a healthcare provider about healthy weight gain.';
    } else if (bmi < 25) {
        category = 'Normal Weight';
        bmiCategory.className = 'bmi-category normal';
        suggestion_text = 'Great! You maintain a healthy weight. Keep up regular exercise and balanced diet.';
    } else if (bmi < 30) {
        category = 'Overweight';
        bmiCategory.className = 'bmi-category overweight';
        suggestion_text = 'Consider adopting healthier eating habits and regular physical activity.';
    } else {
        category = 'Obese';
        bmiCategory.className = 'bmi-category obese';
        suggestion_text = 'Consult with a healthcare provider for personalized weight management advice.';
    }
    bmiCategory.textContent = category;
    suggestion.textContent = suggestion_text;
    resultDiv.style.display = 'block';
}
document.getElementById('height').addEventListener('keypress', e => e.key === 'Enter' && calculateBMI());
document.getElementById('weight').addEventListener('keypress', e => e.key === 'Enter' && calculateBMI());
</script>
