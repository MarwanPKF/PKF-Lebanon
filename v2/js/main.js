/**
 * PKF Chartouni V2 - Core Interactive Controller
 */
document.addEventListener('DOMContentLoaded', () => {
  // 1. Dynamic Copyright Year
  const yearElements = document.querySelectorAll('.dynamic-year');
  const currentYear = new Date().getFullYear();
  yearElements.forEach(el => el.textContent = currentYear);

  // 2. Mobile Menu Navigation
  const mobileMenuBtn = document.getElementById('mobileMenuBtn');
  const mobileMenuDrawer = document.getElementById('mobileMenuDrawer');
  const mobileMenuOverlay = document.getElementById('mobileMenuOverlay');
  const closeMobileMenuBtn = document.getElementById('closeMobileMenuBtn');

  function openMobileMenu() {
    if (!mobileMenuDrawer) return;
    mobileMenuDrawer.classList.remove('translate-x-full');
    if (mobileMenuOverlay) mobileMenuOverlay.classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
  }

  function closeMobileMenu() {
    if (!mobileMenuDrawer) return;
    mobileMenuDrawer.classList.add('translate-x-full');
    if (mobileMenuOverlay) mobileMenuOverlay.classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
  }

  if (mobileMenuBtn) mobileMenuBtn.addEventListener('click', openMobileMenu);
  if (closeMobileMenuBtn) closeMobileMenuBtn.addEventListener('click', closeMobileMenu);
  if (mobileMenuOverlay) mobileMenuOverlay.addEventListener('click', closeMobileMenu);

  // 3. Request a Proposal (RFP) Modal
  const rfpModal = document.getElementById('rfpModal');
  const openRfpBtns = document.querySelectorAll('.open-rfp-btn');
  const closeRfpBtn = document.getElementById('closeRfpBtn');

  function openRfp() {
    if (!rfpModal) return;
    rfpModal.classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
  }

  function closeRfp() {
    if (!rfpModal) return;
    rfpModal.classList.add('hidden');
    document.body.classList.remove('overflow-hidden');
  }

  openRfpBtns.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    openRfp();
  }));

  if (closeRfpBtn) closeRfpBtn.addEventListener('click', closeRfp);
  if (rfpModal) {
    rfpModal.addEventListener('click', (e) => {
      if (e.target === rfpModal) closeRfp();
    });
  }

  // 4. RFP Form Submission Handler
  const rfpForm = document.getElementById('rfpForm');
  if (rfpForm) {
    rfpForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const submitBtn = rfpForm.querySelector('button[type="submit"]');
      const originalText = submitBtn ? submitBtn.innerHTML : 'Submit';
      
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.innerHTML = `
          <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-white inline-block" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8H4z"></path>
          </svg> Submitting to Partner Desk...
        `;
      }

      setTimeout(() => {
        rfpForm.reset();
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerHTML = originalText;
        }
        closeRfp();
        showToast('Thank you! Your request has been directed to a Senior Partner. We will respond within 24 hours.');
      }, 1000);
    });
  }

  // 5. Interactive Practice Tabs (Homepage)
  const tabButtons = document.querySelectorAll('.tab-btn');
  const tabPanels = document.querySelectorAll('.tab-panel');

  tabButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const targetTab = btn.getAttribute('data-tab');

      tabButtons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      tabPanels.forEach(panel => {
        if (panel.getAttribute('id') === targetTab) {
          panel.classList.remove('hidden');
        } else {
          panel.classList.add('hidden');
        }
      });
    });
  });

  // 6. Accordion Functionality (FAQ / Sub-services)
  const accordions = document.querySelectorAll('.accordion-header');
  accordions.forEach(header => {
    header.addEventListener('click', () => {
      const parent = header.closest('.accordion-item');
      if (parent) {
        parent.classList.toggle('open');
      }
    });
  });

  // 7. Toast Notification Utility
  function showToast(message) {
    let toast = document.getElementById('toastNotice');
    if (!toast) {
      toast = document.createElement('div');
      toast.id = 'toastNotice';
      toast.className = 'fixed bottom-6 right-6 z-50 max-w-md bg-slate-900 text-white px-5 py-4 rounded-xl shadow-2xl border border-slate-700 flex items-center gap-3 transition-all duration-300 transform translate-y-12 opacity-0';
      document.body.appendChild(toast);
    }
    toast.innerHTML = `
      <div class="h-8 w-8 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center shrink-0">
        <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
        </svg>
      </div>
      <p class="text-sm font-medium leading-snug">${message}</p>
    `;

    // Animate in
    setTimeout(() => {
      toast.classList.remove('translate-y-12', 'opacity-0');
      toast.classList.add('translate-y-0', 'opacity-100');
    }, 10);

    // Animate out
    setTimeout(() => {
      toast.classList.remove('translate-y-0', 'opacity-100');
      toast.classList.add('translate-y-12', 'opacity-0');
    }, 5000);
  }
});
