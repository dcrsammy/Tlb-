# OMAQ Apparel website
Multi-page static site (index, services, how-it-works, story, gallery, order). No database or build step needed to host. Edit pages in `build.sh` and run `sh build.sh` to regenerate the HTML.

- Set the WhatsApp number in `app.js` (`CONFIG.whatsappNumber`).
- Add photos to `/images` and set `src` for each item in `GALLERY` in `app.js`.
- Orders and fitting requests open WhatsApp with a prefilled message. Stripe and a database come later.
