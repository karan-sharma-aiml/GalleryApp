/* ==================================
   GLOBAL CONFIG
================================== */

// Replace with your WhatsApp number (already used in HTML links)
const WHATSAPP_NUMBER = "9779827286613";

/* ==================================
   WHATSAPP ORDER HELPER
================================== */

/**
 * Open WhatsApp with pre-filled order message
 * @param {string} productName
 * @param {string} price
 */
function orderOnWhatsApp(productName, price) {
  const message =
    `Hello Sharma Watch Store 👋\n` +
    `I want to order:\n` +
    `⌚ Product: ${productName}\n` +
    `💰 Price: ${price}\n` +
    `📍 My location: ____\n` +
    `📞 Contact number: ____\n\n` +
    `Please confirm availability, warranty, and delivery time.`;

  const url = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
  window.open(url, "_blank");
}

/* ==================================
   SMOOTH SCROLL (for anchor links)
================================== */

document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener("click", function (e) {
    e.preventDefault();
    document.querySelector(this.getAttribute("href")).scrollIntoView({
      behavior: "smooth"
    });
  });
});

/* ==================================
   AUTO CURRENT YEAR (FOOTER)
================================== */

document.addEventListener("DOMContentLoaded", () => {
  const yearSpan = document.getElementById("currentYear");
  if (yearSpan) {
    yearSpan.textContent = new Date().getFullYear();
  }
});

/* ==================================
   PWA INSTALL PROMPT (OPTIONAL)
================================== */

let deferredPrompt;

window.addEventListener("beforeinstallprompt", (e) => {
  e.preventDefault();
  deferredPrompt = e;

  const installBtn = document.getElementById("installApp");
  if (installBtn) {
    installBtn.style.display = "block";

    installBtn.addEventListener("click", () => {
      installBtn.style.display = "none";
      deferredPrompt.prompt();

      deferredPrompt.userChoice.then(() => {
        deferredPrompt = null;
      });
    });
  }
});

/* ==================================
   BASIC CLICK FEEDBACK (UX)
================================== */

document.querySelectorAll(".cta").forEach(btn => {
  btn.addEventListener("click", () => {
    btn.style.opacity = "0.85";
    setTimeout(() => {
      btn.style.opacity = "1";
    }, 200);
  });
});
