# MB Vakruska — Site Constitution

> **AGENT INSTRUCTION:** Read this file before every design iteration.
> This is the project's Long-Term Memory.

## 1. Core Identity

- **Project Name:** MB Vakruska Redesign
- **Stitch Project ID:** 10740891951776543529
- **Source site:** https://vakruska.lt
- **Mission:** Improve the visual design of a Lithuanian LocalBusiness site
  without changing functionality, SEO, or content
- **Target Audience:** Lithuanian adults — homestead holiday seekers, farmers
  interested in chicken coops, and small business owners needing consultations
- **Voice:** Professional, trustworthy, modern — not corporate

## 2. The 3 Business Verticals

This is a multi-service site. Every design must clearly present all 3 verticals:

1. **Sodyba** (Holiday Estate) — rental of a countryside property (up to 15 guests)
   near the Jiesia river, Kauno rajonas
2. **Ūkis Eggztasy** (Farm) — sell/distribute Quramo mobile chicken coops (Q6, Q40, Q200)
3. **Verslo pagalba** (Business Help) — consultations: company formation, business plans,
   EU financing (INVEGA/UŽT), website creation

## 3. Architecture & File Structure

- **Root:** `projects/mb-vakruska/`
- **Screens:** `projects/mb-vakruska/screens/` → HTML exports from Stitch
- **Assets:** `projects/mb-vakruska/assets/` → logos, copied imgs if needed
- **Source images:** `c:\Users\37065\Projects\mb_vakruska\web\img\`

## 4. Redesign Sitemap

### Completed
*(none yet)*

### In Progress
- [ ] `hero.html` — Hero section redesign
- [ ] `sodyba.html` — Estate section with 4 service cards
- [ ] `ukis.html` — Farm section with 3 Quramo product cards
- [ ] `verslo-pagalba.html` — Business consultation section
- [ ] `kontaktai.html` — Contact form section
- [ ] `full-page.html` — Full page composition

## 5. Design Constraints (Sacred Rules)

These MUST be preserved in all redesigns:

- Dark background (`#080a0b` or similar near-black)
- Neon green accent (`#39FF14`) — brand signature
- All 3 business sections must be clearly visible on the homepage
- Navigation links: Sodyba, Ūkis, Verslo Pagalba, Susisiekti
- Lithuanian language for all UI text
- Contact form must remain functional
- Real images from `/img/` must be used — no AI placeholders in production

## 6. Design Freedoms

Within constraints, these can be changed:

- Typography — can mix fonts (e.g., Inter for headings, JetBrains Mono for accents)
- Layout — can add hero image, change grid, add new sections
- Animations — add scroll reveals, better micro-animations
- Section order — can reorder or add social proof
- Footer — can expand significantly
- Colors — can add/adjust secondary palette while keeping green accent

## 7. Rules of Engagement

1. Use `DESIGN.md §7` design system block in every Stitch prompt
2. Always generate in `DESKTOP` device type
3. Screen filenames: kebab-case (`hero-redesign.html`)
4. Save every generated `screenId` to `stitch.json` immediately
5. Inform user of every completed screen with a short visual description
6. Do not recreate identical screens — iterate or create new variants
