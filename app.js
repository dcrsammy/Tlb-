// OMAQ Apparel: static site, no database. Orders and fittings open WhatsApp with a prefilled message.
const CONFIG = {
  // TODO: replace with the client's WhatsApp number, international format, digits only (e.g. 447700900123)
  whatsappNumber: "",
};

// Placeholder style catalogue. Replace each `src` with a real photo in /images when the client sends them.
const CATALOG = [
  { id: "OM-W-001", name: "Peplum two-piece set", cat: "Women", src: "images/purple-peplum.jpg" },
  { id: "OM-W-004", name: "Patchwork wide-leg trousers", cat: "Women", src: "images/patchwork-trousers.jpg" },
  { id: "OM-W-002", name: "Occasion dress", cat: "Women", src: "images/tartan-mag.svg" },
  { id: "OM-W-003", name: "Statement skirt", cat: "Women", src: "images/ankara-teal.svg" },
  { id: "OM-M-001", name: "Tailored trousers", cat: "Men", src: "images/adire.svg" },
  { id: "OM-M-002", name: "Traditional set", cat: "Men", src: "images/kente.svg" },
  { id: "OM-C-001", name: "Family matching set", cat: "Children", src: "images/tartan-vio.svg" },
];

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

const waf = document.getElementById("wa-float");
if (waf && CONFIG.whatsappNumber) waf.href = waUrl("Hello OMAQ Apparel");

const burger = document.querySelector(".burger"), menu = document.getElementById("menu");
if (burger) burger.addEventListener("click", () => burger.setAttribute("aria-expanded", menu.classList.toggle("open")));

const store = {
  get() { try { return JSON.parse(localStorage.getItem("omaq-favs")) || []; } catch (e) { return []; } },
  set(v) { try { localStorage.setItem("omaq-favs", JSON.stringify(v)); } catch (e) {} },
};
const countEl = document.getElementById("fav-count");
const syncCount = () => { if (countEl) countEl.textContent = store.get().length; };
const card = i => { const on = store.get().includes(i.id);
  const href = CONFIG.whatsappNumber ? waUrl(`Hello OMAQ Apparel, I am interested in style ${i.id} (${i.name}).`) : `order.html?style=${i.id}`;
  return `<article class="item"><img src="${i.src}" alt="${i.name}" loading="lazy"><div class="meta"><span>${i.id}</span><button class="fav" data-id="${i.id}" aria-label="Save ${i.name}" aria-pressed="${on}">${on ? "&#9829;" : "&#9825;"}</button></div><h3>${i.name}</h3><p>Price on request</p><a class="chat" href="${href}">Chat to the tailor</a></article>`; };

const catalog = document.getElementById("catalog");
if (catalog) {
  let cat = "All"; const pills = document.getElementById("pills");
  const draw = () => {
    catalog.innerHTML = CATALOG.filter(i => cat === "All" || i.cat === cat).map(card).join("");
    const list = CATALOG.filter(i => store.get().includes(i.id));
    document.getElementById("favourites").hidden = !list.length;
    document.getElementById("favlist").innerHTML = list.map(card).join("");
    const msg = "Hello OMAQ Apparel, I would like to order these styles:\n" + list.map(i => `${i.id} ${i.name}`).join("\n");
    document.getElementById("fav-order").href = CONFIG.whatsappNumber ? waUrl(msg) : "order.html";
    syncCount();
  };
  pills.innerHTML = ["All", "Women", "Men", "Children"].map(c => `<button aria-pressed="${c === "All"}">${c}</button>`).join("");
  pills.addEventListener("click", e => { const b = e.target.closest("button"); if (!b) return; cat = b.textContent;
    pills.querySelectorAll("button").forEach(x => x.setAttribute("aria-pressed", x === b)); draw(); });
  document.addEventListener("click", e => { const b = e.target.closest(".fav"); if (!b) return;
    const f = store.get(); store.set(f.includes(b.dataset.id) ? f.filter(x => x !== b.dataset.id) : [...f, b.dataset.id]); draw(); });
  draw();
}
const styleId = new URLSearchParams(location.search).get("style"), itemInput = document.querySelector("#form-order [name=item]");
if (styleId && itemInput) { const m = CATALOG.find(i => i.id === styleId); itemInput.value = m ? `${m.name} (${m.id})` : styleId; }
syncCount();

// Home page scroll story: sketch -> printed fabric -> floating dress -> runway reveal
(() => {
  const track = document.getElementById("track"); if (!track) return;
  const $ = id => document.getElementById(id), stage = $("stage"), chs = [...document.querySelectorAll(".ch")];
  const line = $("line"), fill = $("fill"), dress = $("dress"), book = $("book"), spots = $("spots"), model = $("model"), parts = $("parts"), cta = $("cta"), rev = $("reveal"), prog = $("prog");
  const top = document.querySelector(".top"), L = line.getTotalLength(), still = matchMedia("(prefers-reduced-motion:reduce)").matches;
  line.style.strokeDasharray = L;
  const cl = (v, a = 0, b = 1) => Math.min(b, Math.max(a, v)), seg = (p, a, b) => cl((p - a) / (b - a)), mix = (a, b, t) => a.map((v, i) => Math.round(v + (b[i] - v) * t));
  for (let i = 0; i < 26; i++) { const c = document.createElementNS("http://www.w3.org/2000/svg", "circle"); c.setAttribute("r", 1.5 + (i % 3)); c.setAttribute("fill", ["#e5097f", "#ff7a00", "#00b3a4", "#ffd60a"][i % 4]); c._a = i / 26 * 6.283; c._d = 40 + (i * 37 % 90); parts.appendChild(c); }
  const bounds = [0, .17, .38, .58, .78, 1];
  let cur = 0;
  function draw(p, t) {
    const wide = innerWidth > 740;
    chs.forEach((el, i) => { const a = bounds[i], b = bounds[i + 1], e = Math.min(seg(p, a, a + .04) + (i ? 0 : 1), 1) * (1 - seg(p, b - .04, b) * (i < 4 ? 1 : 0));
      el.style.opacity = e; el.style.transform = `translateY(${(wide ? -50 : 0)}%) translateY(${(1 - e) * 24}px)`; el.style.pointerEvents = e > .5 ? "auto" : "none"; });
    const d = seg(p, .5, .65), bg = mix([241, 237, 230], [11, 10, 12], d), fg = mix([29, 26, 23], [240, 232, 222], d);
    stage.style.setProperty("--bg", `rgb(${bg})`); stage.style.setProperty("--fg", `rgb(${fg})`);
    top.style.setProperty("--hbg", `rgb(${bg})`); top.style.setProperty("--hfg", `rgb(${fg})`);
    book.style.opacity = 1 - seg(p, .4, .55);
    line.style.strokeDashoffset = L * (1 - seg(p, .1, .34)); line.style.stroke = d > .5 ? "#e8d5c0" : "#6b5f55";
    fill.style.opacity = seg(p, .36, .5);
    const pb = seg(p, .38, .6), pf = Math.sin(pb * Math.PI);
    [...parts.children].forEach(c => { const r = c._d * pb * 2.2; c.setAttribute("cx", 200 + Math.cos(c._a) * r); c.setAttribute("cy", 300 + Math.sin(c._a) * r * 1.6); c.setAttribute("opacity", pf * .9); });
    const fl = seg(p, .55, .62), rv = seg(p, .78, .92), s = 1 - rv * .22;
    const y = 120 + (still ? 0 : Math.sin(t / 700) * 10 * fl * (1 - rv)) + rv * 20, rot = still ? 0 : Math.sin(t / 1100) * 3 * fl * (1 - rv);
    dress.setAttribute("transform", `translate(${200 - 100 * s} ${y}) scale(${s}) rotate(${rot} 100 200)`);
    spots.setAttribute("opacity", seg(p, .72, .88)); model.setAttribute("opacity", rv * (1 - seg(p, .84, .92)));
    dress.style.opacity = 1 - seg(p, .84, .92); rev.style.opacity = seg(p, .84, .94);
    cta.style.opacity = seg(p, .93, .99); cta.style.pointerEvents = p > .95 ? "auto" : "none";
    prog.style.width = p * 90 + "vw";
  }
  function tick(t) { const max = track.offsetHeight - stage.offsetHeight, tgt = cl(-track.getBoundingClientRect().top / max); cur = still ? tgt : cur + (tgt - cur) * .1; draw(cur, t); requestAnimationFrame(tick); }
  requestAnimationFrame(tick);
})();
