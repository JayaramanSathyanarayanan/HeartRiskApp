<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("pageTitle", "New Assessment");
    pageContext.setAttribute("navActive", "assess");
%>
<jsp:include page="header.jsp"/>

<main class="page-wrap">

  <div class="assess-hero">
    <div class="badge"><span class="badge-dot"></span>AI-Powered</div>
    <h2>Cardiovascular Risk Assessment</h2>
    <p>Fill in your health data. Results are saved to your profile automatically.</p>
  </div>

  <!-- ════════════════ FORM ════════════════ -->
  <div id="formSection">
    <c:if test="${not empty error}">
      <div class="flash flash-err">⚠ ${error}</div>
    </c:if>

    <form id="assessForm" class="assess-card" novalidate>

      <!-- ── Section 1: Biometrics ─────────────────────── -->
      <div class="section-label s1">Biometrics</div>
      <div class="form-grid-2">
        <div class="fg">
          <label for="age">Age (years)</label>
          <input type="number" id="age" name="age" min="18" max="100" placeholder="18 – 100" required>
          <span class="ferr" id="ageErr"></span>
        </div>
        <div class="fg">
          <label for="gender">Gender</label>
          <select id="gender" name="gender" required>
            <option value="" disabled selected>Select</option>
            <option value="1">Male</option>
            <option value="2">Female</option>
          </select>
          <span class="ferr" id="genderErr"></span>
        </div>
        <div class="fg">
          <label for="height">Height (cm)</label>
          <input type="number" id="height" name="height" min="50" max="250" placeholder="e.g. 175" required>
          <span class="ferr" id="heightErr"></span>
        </div>
        <div class="fg">
          <label for="weight">Weight (kg)</label>
          <input type="number" id="weight" name="weight" min="20" max="300" placeholder="e.g. 70" required>
          <span class="ferr" id="weightErr"></span>
        </div>
      </div>

      <!-- BMI live preview -->
      <div id="bmiPreview" class="bmi-preview" style="display:none">
        BMI: <strong id="bmiVal">—</strong> &nbsp;<span id="bmiCat"></span>
      </div>

      <!-- ── Section 2: Blood Metrics ──────────────────── -->
      <div class="section-label s2">Blood Metrics</div>
      <div class="form-grid-2">
        <div class="fg">
          <label for="ap_hi">Systolic BP (mmHg)</label>
          <input type="number" id="ap_hi" name="ap_hi" min="70" max="250" placeholder="70 – 250" required>
          <span class="ferr" id="ap_hiErr"></span>
        </div>
        <div class="fg">
          <label for="ap_lo">Diastolic BP (mmHg)</label>
          <input type="number" id="ap_lo" name="ap_lo" min="40" max="150" placeholder="40 – 150" required>
          <span class="ferr" id="ap_loErr"></span>
        </div>
        <div class="fg">
          <label for="cholesterol">Cholesterol</label>
          <select id="cholesterol" name="cholesterol" required>
            <option value="" disabled selected>Select</option>
            <option value="1">Normal</option>
            <option value="2">Low</option>
            <option value="3">High</option>
          </select>
          <span class="ferr" id="cholesterolErr"></span>
        </div>
        <div class="fg">
          <label for="gluc">Glucose</label>
          <select id="gluc" name="gluc" required>
            <option value="" disabled selected>Select</option>
            <option value="1">Normal</option>
            <option value="2">Low</option>
            <option value="3">High</option>
          </select>
          <span class="ferr" id="glucErr"></span>
        </div>
      </div>

      <!-- ── Section 3: Lifestyle ───────────────────────── -->
      <div class="section-label s3">Lifestyle</div>
      <div class="form-grid-3">
        <div class="fg">
          <label for="smoking">Smoking</label>
          <select id="smoking" name="smoking" required>
            <option value="" disabled selected>Select</option>
            <option value="1">Smoker</option>
            <option value="0">Non-Smoker</option>
          </select>
          <span class="ferr" id="smokingErr"></span>
        </div>
        <div class="fg">
          <label for="alco">Alcohol</label>
          <select id="alco" name="alco" required>
            <option value="" disabled selected>Select</option>
            <option value="1">Yes</option>
            <option value="0">No</option>
          </select>
          <span class="ferr" id="alcoErr"></span>
        </div>
        <div class="fg">
          <label for="active">Activity Level</label>
          <select id="active" name="active" required>
            <option value="" disabled selected>Select</option>
            <option value="1">Active</option>
            <option value="0">Sedentary</option>
          </select>
          <span class="ferr" id="activeErr"></span>
        </div>
      </div>

      <button type="submit" class="btn-primary btn-full btn-assess" id="submitBtn">
        <span id="btnText">♥ &nbsp;Calculate Risk</span>
        <span id="btnSpinner" style="display:none">Analysing…</span>
      </button>
    </form>
  </div>

  <!-- ════════════════ RESULT ════════════════ -->
  <div id="resultSection" style="display:none">
    <div class="result-card">
      <div class="r-icon-wrap">
        <div class="r-icon">♥</div>
      </div>

      <div class="r-label">Your Risk Level</div>
      <div id="rLevel" class="r-level"></div>
      <div id="rPct"   class="r-pct"></div>

      <!-- Animated gauge -->
      <div class="gauge-wrap">
        <svg class="gauge-svg" viewBox="0 0 200 110">
          <path d="M10,100 A90,90 0 0,1 190,100" fill="none" stroke="rgba(255,255,255,.08)" stroke-width="14" stroke-linecap="round"/>
          <path id="gaugeFill" d="M10,100 A90,90 0 0,1 190,100" fill="none"
                stroke="url(#gGrad)" stroke-width="14" stroke-linecap="round"
                stroke-dasharray="283" stroke-dashoffset="283"
                style="transition:stroke-dashoffset 1.2s cubic-bezier(.4,0,.2,1)"/>
          <defs>
            <linearGradient id="gGrad" x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%"   stop-color="#22c55e"/>
              <stop offset="50%"  stop-color="#f59e0b"/>
              <stop offset="100%" stop-color="#ef4444"/>
            </linearGradient>
          </defs>
        </svg>
      </div>

      <!-- Tips -->
      <div id="rTips" class="r-tips"></div>

      <!-- BMI + BP summary -->
      <div class="r-summary">
        <div class="r-sum-item">
          <span class="r-sum-lbl">BMI</span>
          <span id="rBmi" class="r-sum-val"></span>
        </div>
        <div class="r-sum-item">
          <span class="r-sum-lbl">Category</span>
          <span id="rBmiCat" class="r-sum-val"></span>
        </div>
      </div>

      <div class="r-actions">
        <button onclick="resetForm()" class="btn-secondary">← Re-Assess</button>
        <a href="${pageContext.request.contextPath}/history" class="btn-ghost">View History</a>
      </div>
    </div>
  </div>

</main>

<!-- ════════════════ AJAX Script ════════════════ -->
<script>
const ctx = '${pageContext.request.contextPath}';

// ── Live BMI preview ──────────────────────────────────────────────────────
function updateBmi() {
  const h = parseFloat(document.getElementById('height').value);
  const w = parseFloat(document.getElementById('weight').value);
  const prev = document.getElementById('bmiPreview');
  if (h > 0 && w > 0) {
    const bmi = (w / Math.pow(h / 100, 2)).toFixed(1);
    const cat = bmi < 18.5 ? 'Underweight' : bmi < 25 ? 'Normal' : bmi < 30 ? 'Overweight' : 'Obese';
    document.getElementById('bmiVal').textContent = bmi;
    document.getElementById('bmiCat').textContent = cat;
    prev.style.display = 'flex';
  } else {
    prev.style.display = 'none';
  }
}
document.getElementById('height').addEventListener('input', updateBmi);
document.getElementById('weight').addEventListener('input', updateBmi);

// ── Form validation ───────────────────────────────────────────────────────
function validate() {
  let ok = true;
  const rules = [
    { id:'age',         err:'ageErr',         msg:'Enter age 18–100',     test: v => v>=18&&v<=100 },
    { id:'gender',      err:'genderErr',      msg:'Select gender',        test: v => v===1||v===2 },
    { id:'height',      err:'heightErr',      msg:'Enter height 50–250',  test: v => v>=50&&v<=250 },
    { id:'weight',      err:'weightErr',      msg:'Enter weight 20–300',  test: v => v>=20&&v<=300 },
    { id:'ap_hi',       err:'ap_hiErr',       msg:'Enter systolic 70–250',test: v => v>=70&&v<=250 },
    { id:'ap_lo',       err:'ap_loErr',       msg:'Enter diastolic 40–150',test:v => v>=40&&v<=150 },
    { id:'cholesterol', err:'cholesterolErr', msg:'Select cholesterol',   test: v => [1,2,3].includes(v) },
    { id:'gluc',        err:'glucErr',        msg:'Select glucose',       test: v => [1,2,3].includes(v) },
    { id:'smoking',     err:'smokingErr',     msg:'Select smoking status',test: v => v===0||v===1 },
    { id:'alco',        err:'alcoErr',        msg:'Select alcohol status',test: v => v===0||v===1 },
    { id:'active',      err:'activeErr',      msg:'Select activity level',test: v => v===0||v===1 },
  ];
  rules.forEach(r => {
    const el  = document.getElementById(r.id);
    const err = document.getElementById(r.err);
    const val = parseFloat(el.value);
    if (!r.test(val)) { err.textContent = r.msg; err.style.display='block'; ok=false; }
    else              { err.textContent = '';    err.style.display='none'; }
  });
  return ok;
}

// ── AJAX submit ───────────────────────────────────────────────────────────
document.getElementById('assessForm').addEventListener('submit', async function(e) {
  e.preventDefault();
  if (!validate()) return;

  document.getElementById('btnText').style.display    = 'none';
  document.getElementById('btnSpinner').style.display = 'inline';

  const fd = new FormData(this);
  const params = new URLSearchParams(fd);

  try {
    const res  = await fetch(ctx + '/assess', {
      method:  'POST',
      headers: { 'Accept': 'application/json',
                 'Content-Type': 'application/x-www-form-urlencoded' },
      body:    params.toString()
    });
    const data = await res.json();

    if (data.error) throw new Error(data.error);

    showResult(data);
  } catch(err) {
    alert('Error: ' + err.message);
  } finally {
    document.getElementById('btnText').style.display    = 'inline';
    document.getElementById('btnSpinner').style.display = 'none';
  }
});

// ── Render result ─────────────────────────────────────────────────────────
function showResult(d) {
  document.getElementById('formSection').style.display   = 'none';
  document.getElementById('resultSection').style.display = 'block';

  const lvl = d.riskLevel.toLowerCase().replace(' ', '-');
  document.getElementById('rLevel').textContent  = d.riskLevel + ' Risk';
  document.getElementById('rLevel').className    = 'r-level risk-' + lvl;
  document.getElementById('rPct').textContent    = d.riskPercent + '% probability';
  document.getElementById('rBmi').textContent    = d.bmi;
  document.getElementById('rBmiCat').textContent = d.bmiCategory;

  // Tips: convert newlines to <br>
  document.getElementById('rTips').innerHTML =
    d.tips.split('\n').map(t => '<p>' + t + '</p>').join('');

  // Animate gauge
  const pct     = d.riskPercent / 100;
  const arcLen  = 283;
  const offset  = arcLen - pct * arcLen;
  setTimeout(() => {
    document.getElementById('gaugeFill').style.strokeDashoffset = offset;
  }, 100);

  window.scrollTo({ top: 0, behavior: 'smooth' });
}

function resetForm() {
  document.getElementById('resultSection').style.display = 'none';
  document.getElementById('formSection').style.display   = 'block';
  document.getElementById('assessForm').reset();
  document.getElementById('bmiPreview').style.display    = 'none';
  document.getElementById('gaugeFill').style.strokeDashoffset = 283;
}
</script>


