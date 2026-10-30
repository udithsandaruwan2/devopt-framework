(() => {
  const here = location.pathname.replace(/index\.html$/, "").replace(/\/$/, "") || "/";
  document.querySelectorAll("nav a").forEach((a) => {
    const href = a.getAttribute("href") || "";
    const path = new URL(href, location.href).pathname.replace(/index\.html$/, "").replace(/\/$/, "") || "/";
    if (path === here) a.setAttribute("aria-current", "page");
  });

  document.querySelectorAll("button.copy").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const el = document.getElementById(btn.dataset.copy);
      if (!el) return;
      await navigator.clipboard.writeText(el.textContent.trim());
      const prev = btn.textContent;
      btn.classList.add("copied");
      btn.textContent = "Copied";
      setTimeout(() => { btn.textContent = prev; btn.classList.remove("copied"); }, 1400);
    });
  });

  const pct = document.querySelector("[data-count]");
  const fills = document.querySelectorAll("[data-width]");
  const run = () => {
    if (pct) {
      const target = Number(pct.dataset.count || "0");
      const start = performance.now();
      const tick = (now) => {
        const t = Math.min(1, (now - start) / 900);
        pct.textContent = `${Math.round(target * t)}%`;
        if (t < 1) requestAnimationFrame(tick);
      };
      requestAnimationFrame(tick);
    }
    fills.forEach((el) => { el.style.width = el.dataset.width; });
  };
  if (pct || fills.length) {
    const io = new IntersectionObserver((entries) => {
      if (entries.some((e) => e.isIntersecting)) {
        run();
        io.disconnect();
      }
    }, { threshold: 0.3 });
    io.observe(pct || fills[0]);
  }
})();
