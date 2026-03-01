# Design System: MB Vakruska (vakruska.lt)

**Project ID:** 10740891951776543529
**Source:** https://vakruska.lt
**Analyzed:** 2026-03-01

---

## 1. Visual Theme & Atmosphere

Terminal-meets-nature aesthetic. Deep tech-dark backgrounds with a neon green accent
that references both financial data visualization and organic vitality. The vibe is
"rural business meets Silicon Valley" — minimalist, professional, slightly edgy.

Font choice (JetBrains Mono) reinforces the technical/data character, making a
rural business feel modern and distinctive.

Key adjectives: **dark, minimal, terminal, premium, monospace, neon accent, trustworthy**

---

## 2. Color Palette & Roles

| Name | Hex | Role |
|------|-----|------|
| **Deep Black** | `#080a0b` | Page background — near-black |
| **Card Surface** | `#121519` | Card/section backgrounds |
| **Header Glass** | `rgba(16,20,24,0.96)` | Fixed header backdrop |
| **Neon Green** | `#39FF14` | Primary accent — logo, hover states, CTA borders, badge text |
| **Electric Blue** | `#00a3ff` | Secondary accent — info badges |
| **Text White** | `#ffffff` | Primary text, headings |
| **Text Muted** | `#8a939b` | Secondary text, nav links |
| **Green Border** | `rgba(57,255,20,0.15)` | Card borders, section borders |
| **Green Border Active** | `rgba(57,255,20,0.9)` | Header bottom gradient, hover borders |

---

## 3. Typography Rules

| Role | Font | Weight | Notes |
|------|------|--------|-------|
| All text | JetBrains Mono | 400/600/700/800 | Monospace throughout |
| Logo | JetBrains Mono | 800 | 1.4rem, accent green |
| H1 Hero | JetBrains Mono | 800 | clamp(2.4rem, 6vw, 4.5rem), gradient text (white→#ccc) |
| Section H2 | JetBrains Mono | 800 | ~2rem, white |
| Body copy | JetBrains Mono | 400 | 1rem–1.1rem, muted |
| Badges | JetBrains Mono | 800 | 0.75rem, uppercase |

Letter spacing: `-0.015em` global, `-0.04em` on headlines
Line height: `1.6` global

---

## 4. Component Stylings

### Navigation
- Fixed top, glassmorphism backdrop (`backdrop-filter: blur(20px)`)
- Bottom border: gradient line green glow across full width
- Logo: neon green, weight 800
- Nav links: muted text → neon green on hover with sliding underline animation
- Mobile: full-screen slide-in from right at ≤850px

### Cards
- Background: `#121519` (card-bg)
- Border: `1px solid rgba(57,255,20,0.15)`
- Border-radius: `20px`
- Hover: `translateY(-10px)` + border turns full neon green + deep shadow
- Badges: pill-shaped, green or blue tinted backgrounds

### Buttons
- Primary: neon green background, black text, hover glow effect
- Secondary: transparent + green border, green text
- Border-radius: varies (`8px`–`100px` for pills)

### Hero Section
- Centered, large padding-top for fixed header offset
- Card-border box around entire hero
- H1 with gradient text technique
- CTA buttons side by side

### Image Cards
- Full-width `<img>` inside cards with `border-radius: 14px`
- Images are always real photos (from `/img/`)

---

## 5. Layout Principles

- Container: max-width `1200px`, centered, `2rem` padding
- Section spacing: `5rem 0` for major sections
- Grid: `repeat(3, 1fr)` for service cards, `1.5rem` gap
- Mobile column: single column at ≤700px
- Scroll offset: `6rem` for fixed header anchor links

---

## 6. Page Sections (Current Site Map)

```
1. Header (fixed) — Logo "MB Vakruška" + nav links
   Links: Sodyba | Ūkis | Verslo Pagalba | Susisiekti
   Dropdown: Ūkis → Vištidės, Kiaušiniai

2. Hero — "Trys keliai į geresnį gyvenimą"
   3 CTA buttons: Sodyba, Ūkis Eggztasy, Verslo Pagalba
   Subtext: briefly describes all 3 business verticals

3. Sodyba (Estate Rental)
   4 cards: [Poilsis] [Pramogos] [Aplinka] [Namelis]
   Images: actual photos from /img/

4. Ūkis Eggztasy (Farm / Quramo Chicken Coops)
   3 product cards: Q6 (modular, 324–864 birds), Q40 (50 hens), Q200 (120 hens)
   Images: product photos from /img/
   CTA: contact for quote

5. Verslo pagalba (Business Consultations)
   4 cards: Įmonių steigimas | Verslo planai | Finansavimas (INVEGA/UŽT) | Interneto svetainės
   Images: professional/concept photos

6. Kontaktai (Contact)
   Contact form: name, email, service dropdown, message
   Cloudflare Turnstile CAPTCHA

7. Footer
   Minimal: company name, rights reserved
```

---

## 7. Design System Notes for Stitch Generation

**Copy this block into every screen prompt:**

```
DESIGN SYSTEM (REQUIRED):
- Platform: Web, Desktop-first (responsive to mobile)
- Theme: Dark terminal aesthetic, near-black background
- Background: Deep near-black (#080a0b)
- Card Surface: Dark charcoal (#121519)
- Primary Accent: Neon green (#39FF14) — used for logo, CTAs, borders, hover states
- Secondary Accent: Electric blue (#00a3ff) — info/secondary badges
- Text Primary: White (#ffffff)
- Text Secondary: Muted gray (#8a939b)
- Font: JetBrains Mono (monospace) — weight 400/700/800
- Border: 1px solid rgba(57,255,20,0.15) on cards
- Cards: rounded-xl (20px), hover lifts -10px with neon green border
- Header: fixed, glassmorphism blur, neon green gradient bottom border
- Layout: max-width 1200px, centered, 3-column card grid
- Vibe: terminal-meets-rural-premium, monospace tech feel, professional dark
```

---

## 8. Areas for Redesign (Opportunities)

| Area | Current | Opportunity |
|------|---------|-------------|
| Hero | Text + 3 buttons, no image | Add hero image/background |
| Section dividers | None | Subtle green glow separators |
| Typography | Mono only | Consider mixing serif for headings |
| Animations | Card hover only | Scroll-triggered reveals |
| Social proof | None | Add testimonials section |
| Mobile nav | Functional | Could be more polished |
| Footer | Minimal | Expand with links, contact info |
