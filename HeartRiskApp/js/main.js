/* CardioAssess — main.js
   General client-side helpers loaded on every page.
   Page-specific AJAX logic lives inline in assess.jsp.
*/

// ── Live clock in navbar (if element present) ─────────────────────────────
(function startClock() {
  const el = document.getElementById('navClock');
  if (!el) return;
  function tick() {
    const n = new Date();
    el.textContent = [n.getHours(), n.getMinutes(), n.getSeconds()]
      .map(v => String(v).padStart(2, '0')).join(':');
  }
  tick();
  setInterval(tick, 1000);
})();

// ── Highlight active nav link (fallback if JSP attr not set) ─────────────
(function highlightNav() {
  const path = window.location.pathname;
  document.querySelectorAll('.nav-links a').forEach(a => {
    const href = a.getAttribute('href') || '';
    if (path.endsWith(href.split('/').pop()) && href.length > 1) {
      a.classList.add('active');
    }
  });
})();

// ── Auto-dismiss flash messages after 5 s ────────────────────────────────
(function autoDismissFlash() {
  document.querySelectorAll('.flash').forEach(el => {
    setTimeout(() => {
      el.style.transition = 'opacity .5s';
      el.style.opacity = '0';
      setTimeout(() => el.remove(), 500);
    }, 5000);
  });
})();

// ── Input: allow only numeric keys for number fields ─────────────────────
document.querySelectorAll('input[type=number]').forEach(input => {
  input.addEventListener('wheel', e => e.preventDefault()); // prevent scroll-to-change
});

// ── Password strength indicator (register page) ──────────────────────────
const pwdInput = document.getElementById('password');
const confirmInput = document.getElementById('confirmPassword');

if (pwdInput && confirmInput) {
  confirmInput.addEventListener('input', function () {
    if (this.value && this.value !== pwdInput.value) {
      this.style.borderColor = 'rgba(239,68,68,.7)';
    } else if (this.value) {
      this.style.borderColor = 'rgba(34,197,94,.7)';
    } else {
      this.style.borderColor = '';
    }
  });
}
