#!/bin/sh
# Generates the static pages. Run: sh build.sh
NAV="index:Home services:Services how-it-works:How_it_works story:Our_story gallery:Gallery"
page(){ f=$1; cur=$2; title=$3; cls=$4; h1=$5; sub=$6
links=""; for n in $NAV; do k=${n%%:*}; t=$(echo "${n#*:}"|tr _ ' '); a=""; [ "$k" = "$cur" ] && a=' aria-current="page"'; links="$links<a href=\"$k.html\"$a>$t</a>"; done
cat > "$f" <<EOT
<!DOCTYPE html>
<html lang="en-GB"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title | OMAQ Apparel</title>
<meta name="description" content="Timeless, unique custom outfits for all genders and ages. Fabric sourcing, in-person fittings in Scotland, UK-wide delivery.">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bodoni+Moda:ital,wght@0,500;0,700;1,500&family=Figtree:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="styles.css"></head><body>
<header class="top"><a class="logo" href="index.html">OMAQ <span>Apparel</span></a><nav aria-label="Main">$links<a class="btn" href="order.html"$([ "$cur" = order ] && echo ' aria-current="page"')>Order or book</a></nav></header>
<main><section class="phead $cls"><div class="in"><h1>$h1</h1><p>$sub</p></div></section>
EOT
cat >> "$f"
cat >> "$f" <<'EOT'
</main>
<footer><p><b>OMAQ Apparel</b>, Scotland, United Kingdom</p><p><a id="wa-link" href="#">WhatsApp</a><a href="https://www.instagram.com/omaq_apparel" rel="noopener">Instagram</a><a href="https://vm.tiktok.com/ZN8Bhapgd/" rel="noopener">TikTok</a></p></footer>
<script src="app.js"></script></body></html>
EOT
}

page index.html index "Custom outfits" "c-mag home" "Timeless. Unique. Yours." 'Custom wears for every gender and age, made from your measurements in the fabric you choose. Based in Scotland, delivering across the UK.<span class="cta"><a class="btn yel" href="order.html">Order a piece</a><a class="btn line" href="order.html?tab=fitting">Book a fitting</a></span>' <<'B'
<nav class="tiles" aria-label="Explore">
<a class="c-org" href="services.html"><b>What we make</b><span>Women, men, children and fabric sourcing</span></a>
<a class="c-vio" href="how-it-works.html"><b>How it works</b><span>From idea to delivery in five steps</span></a>
<a class="c-teal" href="story.html"><b>Our story</b><span>Where OMAQ began</span></a>
<a class="c-yel" href="gallery.html"><b>Recent work</b><span>See what we have made</span></a>
</nav>
B

page services.html services "What we make" c-org "What we make" "Custom wear for all genders and ages, cut to you." <<'B'
<section class="wrap"><dl class="services">
<div><dt>Women</dt><dd>Dresses, blouses, skirts, trousers, two-piece sets and outfits for your outing.</dd></div>
<div><dt>Men</dt><dd>Shirts, trousers, suits and traditional wear, cut to your measurements.</dd></div>
<div><dt>Children</dt><dd>Matching family outfits and special-day wear for all ages.</dd></div>
<div><dt>Fabric sourcing</dt><dd>Tell us the look. We find the fabric and you approve it before we cut.</dd></div>
</dl><p class="note">Every piece is different, so each one is priced after we talk about your design.</p>
<p><a class="btn" href="order.html">Order a piece</a></p></section>
B

page how-it-works.html how-it-works "How it works" c-vio "How it works" "Five steps from idea to your door."  <<'B'
<section class="wrap"><ol class="steps">
<li><b>Tell us your idea.</b> Send a request or photos of what you like.</li>
<li><b>Agree the details.</b> We chat on WhatsApp about fabric, style, price and timing.</li>
<li><b>Measurements and fitting.</b> In person in Scotland. Guided measuring for the rest of the UK.</li>
<li><b>We make it.</b> You see progress before it is finished.</li>
<li><b>Delivery or pickup.</b> Tracked UK delivery, or collect in Scotland. Worldwide shipping is coming.</li>
</ol><p class="note">Payment is arranged on WhatsApp for now. Card payment is coming soon.</p>
<p><a class="btn" href="order.html">Start your order</a></p></section>
B

page story.html story "Our story" c-mag "Our story" "Where OMAQ Apparel began." <<'B'
<section class="wrap story"><p>It began with a father who knew how to put an outfit together, and a daughter who was watching. He bought her her first heels.</p>
<p>Later, she saw her aunt's sewing machine and started cutting paper into blouses, skirts and trousers.</p>
<p>That paper became cloth. Today OMAQ Apparel makes clothes that are unique to the person wearing them.</p>
<p><a class="btn" href="gallery.html">See recent work</a></p></section>
B

page gallery.html gallery "Recent work" c-teal "Recent work" "A look at what we have made." <<'B'
<section class="wrap"><div class="gallery" id="gallery-grid"></div>
<p class="note">Photos of finished pieces are coming soon. Follow us on Instagram and TikTok to see new work first.</p></section>
B

page order.html order "Order or book" c-yel "Order or book" "Request a piece or book a fitting. We reply on WhatsApp." <<'B'
<section class="wrap order">
<div class="tabs" role="tablist"><button role="tab" aria-selected="true" data-tab="order">Order a piece</button><button role="tab" aria-selected="false" data-tab="fitting">Book a fitting</button></div>
<form id="form-order" class="panel" novalidate>
<label>Your name<input name="name" required autocomplete="name"></label>
<label>Who is it for?<select name="who"><option>Woman</option><option>Man</option><option>Child</option></select></label>
<label>What would you like made?<input name="item" required placeholder="e.g. two-piece set for a wedding"></label>
<label>Occasion and date needed<input name="date" placeholder="e.g. 14 December"></label>
<label>Fabric<select name="fabric"><option>I have my own fabric</option><option>Please source fabric for me</option><option>Not sure yet</option></select></label>
<label>Delivery<select name="delivery"><option>Scotland, in-person fitting</option><option>Elsewhere in the UK</option><option>Outside the UK</option></select></label>
<label>Extra details<textarea name="notes" rows="3" placeholder="Colours, style ideas, inspiration"></textarea></label>
<button class="btn" type="submit">Send request on WhatsApp</button>
<p class="note">Payment is arranged on WhatsApp for now. Card payment is coming soon.</p><p class="error" role="alert"></p></form>
<form id="form-fitting" class="panel" hidden novalidate>
<p class="note">In-person fittings are available in Scotland.</p>
<label>Your name<input name="name" required autocomplete="name"></label>
<label>Town or city in Scotland<input name="town" required></label>
<label>Preferred date<input name="date" type="date" required></label>
<label>Preferred time<select name="time"><option>Morning</option><option>Afternoon</option><option>Evening</option></select></label>
<label>What is the fitting for?<input name="item" placeholder="e.g. measurements for a suit"></label>
<button class="btn" type="submit">Request fitting on WhatsApp</button><p class="error" role="alert"></p></form>
</section>
B
