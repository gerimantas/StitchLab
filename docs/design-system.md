# StitchLab Design System

> Reference guide for consistent design decisions across all StitchLab projects.

---

## Typography

### Preferred Font Pairings

| Use | Font | Weight |
|-----|------|--------|
| Primary UI | Inter | 400, 500, 600, 700 |
| Display / Hero | Outfit | 700, 800 |
| Data / Tables | DM Mono | 400, 500 |
| Alternative | Plus Jakarta Sans | 400, 600, 700 |

---

## Color Palettes

### Dark Professional (default)
```
Background:  #0A0F1E (deep navy)
Surface:     #111827 (dark gray)
Card:        #1F2937 (lighter dark)
Accent:      #7C3AED (purple)
Text:        #F9FAFB (near white)
Muted:       #6B7280 (gray)
Border:      #374151 (subtle border)
```

### Clean Light
```
Background:  #FFFFFF
Surface:     #F9FAFB
Card:        #FFFFFF (with shadow)
Accent:      #6366F1 (indigo)
Text:        #111827
Muted:       #6B7280
Border:      #E5E7EB
```

### Emerald Dark
```
Background:  #0D1117
Surface:     #161B22
Card:        #21262D
Accent:      #10B981 (emerald)
Text:        #F0F6FC
Muted:       #8B949E
Border:      #30363D
```

---

## Layout Patterns

### Web App (Desktop)
- Fixed sidebar: 240px wide
- Top header: 60px height
- Main content: padding 24px
- Card grid: 3-4 columns

### Landing Page
- Max width: 1200px centered
- Section padding: 80-120px vertical
- Hero: full-width with gradient

### Mobile App
- Bottom navigation bar
- 16px horizontal padding
- Cards: full-width, 12px radius

---

## Component Standards

### Cards
- Border radius: 12px (standard), 16px (featured)
- Shadow: `0 1px 3px rgba(0,0,0,0.1)` (light), `0 4px 24px rgba(0,0,0,0.3)` (dark)
- Padding: 20-24px

### Buttons
- Primary: filled accent color, 8px radius
- Secondary: outlined, same radius
- Height: 40px (normal), 48px (large CTA)

### Glassmorphism (when used)
- Background: `rgba(255,255,255,0.05)`
- Backdrop filter: `blur(10px)`
- Border: `1px solid rgba(255,255,255,0.1)`
