(function () {
  "use strict";

  const root = document.documentElement;
  const themeSelect = document.getElementById("theme-select");
  const schemeToggle = document.getElementById("scheme-toggle");
  const navToggle = document.querySelector(".nav-toggle");
  const nav = document.getElementById("site-nav");

  const savedTheme = localStorage.getItem("astis-theme");
  const savedScheme = localStorage.getItem("astis-color-scheme");
  if (savedTheme && ["blueprint", "modern", "bold"].includes(savedTheme)) {
    root.dataset.theme = savedTheme;
  }
  if (savedScheme && ["light", "dark"].includes(savedScheme)) {
    root.dataset.colorScheme = savedScheme;
  } else if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
    root.dataset.colorScheme = "dark";
  }
  if (themeSelect) {
    themeSelect.value = root.dataset.theme;
    themeSelect.addEventListener("change", () => {
      root.dataset.theme = themeSelect.value;
      localStorage.setItem("astis-theme", themeSelect.value);
    });
  }
  if (schemeToggle) {
    schemeToggle.addEventListener("click", () => {
      root.dataset.colorScheme = root.dataset.colorScheme === "dark" ? "light" : "dark";
      localStorage.setItem("astis-color-scheme", root.dataset.colorScheme);
    });
  }
  if (navToggle && nav) {
    navToggle.addEventListener("click", () => {
      const open = nav.classList.toggle("open");
      navToggle.setAttribute("aria-expanded", String(open));
    });
  }

  function filterCards() {
    const search = document.getElementById("card-search");
    const status = document.getElementById("status-filter");
    const cards = document.querySelectorAll("#filterable-cards .correspondence-card");
    if (!cards.length) return;
    const run = () => {
      const query = (search?.value || "").trim().toLowerCase();
      const statusValue = status?.value || "";
      cards.forEach((card) => {
        const searchMatch = !query || card.textContent.toLowerCase().includes(query);
        const statusMatch = !statusValue || card.dataset.status === statusValue;
        card.hidden = !(searchMatch && statusMatch);
      });
    };
    search?.addEventListener("input", run);
    status?.addEventListener("change", run);
  }

  function filterImplementation() {
    const search = document.getElementById("implementation-search");
    const status = document.getElementById("implementation-status");
    const rows = document.querySelectorAll("#implementation-table tbody tr");
    if (!rows.length) return;
    const run = () => {
      const query = (search?.value || "").trim().toLowerCase();
      const statusValue = status?.value || "";
      rows.forEach((row) => {
        const searchMatch = !query || (row.dataset.search || row.textContent.toLowerCase()).includes(query);
        const statusMatch = !statusValue || row.dataset.status === statusValue;
        row.hidden = !(searchMatch && statusMatch);
      });
    };
    search?.addEventListener("input", run);
    status?.addEventListener("change", run);
  }

  function highlightLean() {
    const keywords = /\b(theorem|lemma|def|abbrev|structure|class|inductive|namespace|end|where|by|fun|let|have|show|exact|apply|refine|intro|constructor|cases|simpa|simp|rw|calc|match|with|if|then|else|∀|∃)\b/g;
    const types = /\b(Prop|Type|Set|Measure|Integrable|Tendsto|HasFDerivAt|DifferentiableAt|ContinuousLinearMap|EuclideanSpace|PiLp|ENNReal|ℝ|ℕ)\b/g;
    const numbers = /\b\d+(?:\.\d+)?\b/g;
    document.querySelectorAll("code.language-lean").forEach((node) => {
      let value = node.textContent;
      value = value
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
      const protectedParts = [];
      value = value.replace(/\/-![\s\S]*?-\/|\/--[\s\S]*?-\/|--[^\n]*/g, (part) => {
        protectedParts.push(`<span class="tok-comment">${part}</span>`);
        return `\uE000${String.fromCharCode(0xE100 + protectedParts.length - 1)}\uE001`;
      });
      value = value.replace(/"([^"\\]|\\.)*"/g, (part) => {
        protectedParts.push(`<span class="tok-string">${part}</span>`);
        return `\uE000${String.fromCharCode(0xE100 + protectedParts.length - 1)}\uE001`;
      });
      value = value.replace(keywords, '<span class="tok-keyword">$1</span>');
      value = value.replace(types, '<span class="tok-type">$1</span>');
      value = value.replace(numbers, '<span class="tok-number">$&</span>');
      value = value.replace(/\uE000([\uE100-\uF8FF])\uE001/g, (_, marker) => {
        return protectedParts[marker.charCodeAt(0) - 0xE100];
      });
      node.innerHTML = value;
    });
  }

  function loadMermaid() {
    if (!document.querySelector(".mermaid")) return;
    const script = document.createElement("script");
    script.type = "module";
    script.textContent = `
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({
        startOnLoad: true,
        theme: document.documentElement.dataset.colorScheme === "dark" ? "dark" : "neutral",
        flowchart: { curve: "basis", htmlLabels: true, useMaxWidth: true },
        themeVariables: { fontFamily: "Inter, system-ui, sans-serif", fontSize: "15px" }
      });
    `;
    document.body.appendChild(script);
  }

  filterCards();
  filterImplementation();
  highlightLean();
  loadMermaid();
})();
