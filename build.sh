#!/bin/sh
# Generates the static pages. Run: sh build.sh
NAV="collection:Collection services:Services how-it-works:How_it_works measure:Measurements story:Our_story"
page(){ f=$1; cur=$2; title=$3; cls=$4; h1=$5; sub=$6; art=""; case "$cls" in *home*) art="$7";; esac
links=""; for n in $NAV; do k=${n%%:*}; t=$(echo "${n#*:}"|tr _ ' '); a=""; [ "$k" = "$cur" ] && a=' aria-current="page"'; links="$links<a href=\"$k.html\"$a>$t</a>"; done
cat > "$f" <<EOT
<!DOCTYPE html>
<html lang="en-GB"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>$title | OMAQ Apparel</title>
<meta name="description" content="Timeless, unique custom outfits for all genders and ages. Fabric sourcing, in-person fittings in Scotland, UK-wide delivery.">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Hanken+Grotesk:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="styles.css"></head><body>
<div class="bar">Fittings in Scotland. Delivery across the UK.</div>
<header class="top"><a class="logo" href="index.html">OMAQ <span>Apparel</span></a><div class="tools"><a class="heart" href="collection.html#favourites" aria-label="Favourites">&#9825; <span id="fav-count">0</span></a><button class="burger" aria-label="Menu" aria-expanded="false">&#9776;</button></div><nav id="menu" aria-label="Main">$links<a class="btn" href="order.html"$([ "$cur" = order ] && echo ' aria-current="page"')>Order or book</a></nav></header>
<main><section class="phead $cls"><div class="in"><div><h1>$h1</h1><p>$sub</p></div>$art</div></section>
EOT
cat >> "$f"
cat >> "$f" <<'EOT'
</main>
<footer><p><b>OMAQ Apparel</b>, Scotland, United Kingdom</p><p><a id="wa-link" href="#">WhatsApp</a><a href="https://www.instagram.com/omaq_apparel" rel="noopener">Instagram</a><a href="https://vm.tiktok.com/ZN8Bhapgd/" rel="noopener">TikTok</a></p></footer>
<a class="wa-float" id="wa-float" href="order.html" aria-label="Chat on WhatsApp"><svg viewBox="0 0 24 24" width="28" height="28" fill="#fff"><path d="M12 2a10 10 0 0 0-8.6 15L2 22l5.2-1.4A10 10 0 1 0 12 2zm5.2 13.9c-.2.6-1.3 1.2-1.8 1.2-.5.1-1 .2-3.3-.7-2.8-1.1-4.6-4-4.7-4.2-.1-.2-1.1-1.5-1.1-2.8 0-1.3.7-1.9.9-2.2.2-.2.5-.3.7-.3h.5c.2 0 .4 0 .6.5l.8 2c.1.2.1.4 0 .5l-.4.6c-.1.2-.3.3-.1.6.2.3.8 1.3 1.7 2.1 1.2 1 2.2 1.3 2.5 1.5.3.1.4.1.6-.1l.8-1c.2-.3.4-.2.6-.1l1.9.9c.3.1.5.2.5.3.1.1.1.6-.1 1.1z"/></svg></a>
<script src="app.js"></script></body></html>
EOT
}

A(){ echo "<img class=\"art\" src=\"images/$1\" alt=\"\">"; }
page index.html index "Custom outfits" "c-mag home" 'Timeless.<span>Unique.</span><span>Yours.</span>' 'Custom wears for every gender and age, made from your measurements in the fabric you choose. Based in Scotland, delivering across the UK.<span class="cta"><a class="btn yel" href="collection.html">View the collection</a><a class="btn line" href="order.html">Order a piece</a></span>' '<div class="swatches"><figure class="s1"><img src="images/ankara-org.svg" alt=""><figcaption>OM-W-001</figcaption></figure><figure class="s2"><img src="images/tartan-vio.svg" alt=""><figcaption>OM-C-001</figcaption></figure><figure class="s3"><img src="images/kente.svg" alt=""><figcaption>OM-M-002</figcaption></figure></div>' <<'B'
<div class="ruler" aria-hidden="true"></div>
<section class="wrap"><h2>The collection</h2><div class="look">
<a class="l1" href="collection.html"><img src="images/ankara-org.svg" alt=""><span>Two-piece sets</span></a>
<a class="l2" href="collection.html"><img src="images/tartan-mag.svg" alt=""><span>Occasion dresses</span></a>
<a class="l3" href="collection.html"><img src="images/kente.svg" alt=""><span>Menswear</span></a></div>
<a class="btn" href="collection.html">View all styles</a></section>
<section class="statement"><p>Every piece is different. So is every client.</p></section>
<section class="wrap"><h2>How it works</h2><ol class="steps">
<li><span><b>Tell us your idea.</b> Send a request or photos of what you like.</span></li>
<li><span><b>Agree the details.</b> We chat on WhatsApp about fabric, style, price and timing.</span></li>
<li><span><b>Measurements and fitting.</b> In person in Scotland. Guided measuring for the rest of the UK.</span></li>
<li><span><b>We make it.</b> You see progress before it is finished.</span></li>
<li><span><b>Delivery or pickup.</b> Tracked UK delivery, or collect in Scotland.</span></li></ol></section>
<section class="cta-band"><div><h2>Start with an idea.</h2><p>Send a request, or book a fitting if you are in Scotland.</p><a class="btn" href="order.html">Order a piece</a> <a class="btn line dark" href="order.html?tab=fitting">Book a fitting</a></div></section>
B

page services.html services "What we make" c-org "What we make" "Custom wear for all genders and ages, cut to you." "" <<'B'
<section class="rows">
<article class="r1"><img src="images/tartan-mag.svg" alt=""><div><h2>Women</h2><p>Dresses, blouses, skirts, trousers, two-piece sets and outfits for your outing.</p></div></article>
<article class="r2"><img src="images/kente.svg" alt=""><div><h2>Men</h2><p>Shirts, trousers, suits and traditional wear, cut to your measurements.</p></div></article>
<article class="r3"><img src="images/ankara-org.svg" alt=""><div><h2>Children</h2><p>Matching family outfits and special-day wear for all ages.</p></div></article>
<article class="r4"><img src="images/adire.svg" alt=""><div><h2>Fabric sourcing</h2><p>Tell us the look. We find the fabric and you approve it before we cut.</p></div></article></section>
<section class="wrap"><p class="note">Every piece is different, so each one is priced after we talk about your design.</p><a class="btn" href="order.html">Order a piece</a></section>
B

page how-it-works.html how-it-works "How it works" c-vio "How it works" "Five steps from idea to your door." "" <<'B'
<section class="wrap"><ol class="steps">
<li><span><b>Tell us your idea.</b> Send a request or photos of what you like.</span></li>
<li><span><b>Agree the details.</b> We chat on WhatsApp about fabric, style, price and timing.</span></li>
<li><span><b>Measurements and fitting.</b> In person in Scotland. Guided measuring for the rest of the UK.</span></li>
<li><span><b>We make it.</b> You see progress before it is finished.</span></li>
<li><span><b>Delivery or pickup.</b> Tracked UK delivery, or collect in Scotland. Worldwide shipping is coming.</span></li></ol>
<p class="note">Payment is arranged on WhatsApp for now. Card payment is coming soon.</p><a class="btn" href="order.html">Start your order</a></section>
B

page story.html story "Our story" c-mag "Our story" "Where OMAQ Apparel began." "" <<'B'
<section class="wrap split"><figure class="figure"><img src="images/dress-form.svg" alt="Dress form wearing a printed outfit"></figure>
<div class="story"><p>It began with a father who knew how to put an outfit together, and a daughter who was watching. He bought her her first heels.</p>
<p>Later, she saw her aunt's sewing machine and started cutting paper into blouses, skirts and trousers.</p>
<p>That paper became cloth. Today OMAQ Apparel makes clothes that are unique to the person wearing them.</p>
<a class="btn" href="collection.html">See the collection</a></div></section>
B

page measure.html measure "How to measure" c-vio "How to measure" "Six measurements, one soft tape, about ten minutes. Order from anywhere in the UK." "" <<'B'
<section class="wrap"><ol class="steps">
<li><b>Bust or chest.</b> Wrap the tape around the fullest part, level under the arms. Snug, not tight.</li>
<li><b>Waist.</b> Measure the narrowest part of your torso, about an inch above the navel.</li>
<li><b>Hips.</b> Feet together, measure around the fullest part of your hips and seat.</li>
<li><b>Shoulder.</b> Measure across your back from one shoulder point to the other.</li>
<li><b>Arm length.</b> From the shoulder point to the wrist, with your arm slightly bent.</li>
<li><b>Height.</b> Stand against a wall without shoes and measure to the top of your head.</li></ol>
<p class="note">Wear fitted clothes, ask a friend to help, and measure twice. In Scotland we can take your measurements in person at a fitting.</p>
<p><a class="btn" href="order.html">Send your order</a> <a class="btn line dark" href="order.html?tab=fitting">Book a fitting</a></p></section>
B

page collection.html collection "Collection" c-mag "The collection" "Styles we make. Every piece can be made to your own measurements." "" <<'B'
<section class="wrap"><div class="pills" id="pills"></div><div class="catalog" id="catalog"></div>
<p class="note">Photos of finished pieces are coming soon. Prices are agreed with you for each piece.</p></section>
<section class="wrap" id="favourites" hidden><h2>Your favourites</h2><div class="catalog" id="favlist"></div><p><a class="btn" id="fav-order" href="order.html">Order these on WhatsApp</a></p></section>
B

page order.html order "Order or book" c-yel "Order or book" "Request a piece or book a fitting. We reply on WhatsApp." "$(A adire.svg)" <<'B'
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
