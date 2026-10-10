// OMAQ Apparel: static site, no database. Orders and fittings open WhatsApp with a prefilled message.
const CONFIG = {
  // TODO: replace with the client's WhatsApp number, international format, digits only (e.g. 447700900123)
  whatsappNumber: "",
};

// Placeholder gallery art. Replace each `src` with a real photo in /images when the client sends them.
const GALLERY = [
  { src: "images/tartan-mag.svg", label: "Occasion dress" }, { src: "images/ankara-org.svg", label: "Two-piece set" },
  { src: "images/adire.svg", label: "Tailored trousers" }, { src: "images/kente.svg", label: "Family matching set" },
  { src: "images/ankara-teal.svg", label: "Statement skirt" }, { src: "images/tartan-vio.svg", label: "Wedding guest outfit" },
];
const grid = document.getElementById("gallery-grid");
if (grid) grid.innerHTML = GALLERY.map((g, i) => `<figure class="${i % 3 === 0 ? "tall" : ""}"><img src="${g.src}" alt="${g.label}" loading="lazy"><figcaption>${g.label}</figcaption></figure>`).join("");

const waUrl = text => `https://wa.me/${CONFIG.whatsappNumber}?text=${encodeURIComponent(text)}`;
document.getElementById("wa-link").href = CONFIG.whatsappNumber ? waUrl("Hello OMAQ Apparel") : "https://www.instagram.com/omaq_apparel";

function showTab(name) {
  if (!document.getElementById("form-order")) return;
  document.querySelectorAll(".tabs button").forEach(b => b.setAttribute("aria-selected", b.dataset.tab === name));
  document.getElementById("form-order").hidden = name !== "order";
  document.getElementById("form-fitting").hidden = name !== "fitting";
}
document.querySelectorAll("button[data-tab]").forEach(el => el.addEventListener("click", () => showTab(el.dataset.tab)));
showTab(new URLSearchParams(location.search).get("tab") === "fitting" ? "fitting" : "order");

function handle(formId, build) {
  const form = document.getElementById(formId);
  if (!form) return;
  form.addEventListener("submit", e => {
    e.preventDefault();
    const err = form.querySelector(".error");
    const d = Object.fromEntries(new FormData(form));
    const missing = [...form.querySelectorAll("[required]")].find(i => !i.value.trim());
    if (missing) { err.textContent = `Please fill in: ${missing.closest("label").firstChild.textContent.trim()}.`; missing.focus(); return; }
    if (!CONFIG.whatsappNumber) { err.textContent = "WhatsApp number not set yet. Message us on Instagram @omaq_apparel."; return; }
    err.textContent = "";
    window.open(waUrl(build(d)), "_blank", "noopener");
  });
}
handle("form-order", d => `Hello OMAQ Apparel, I would like to order a piece.\nName: ${d.name}\nFor: ${d.who}\nItem: ${d.item}\nNeeded by: ${d.date || "flexible"}\nFabric: ${d.fabric}\nDelivery: ${d.delivery}\nDetails: ${d.notes || "none"}`);
handle("form-fitting", d => `Hello OMAQ Apparel, I would like to book a fitting.\nName: ${d.name}\nTown: ${d.town}\nDate: ${d.date}\nTime: ${d.time}\nFor: ${d.item || "not sure yet"}`);
