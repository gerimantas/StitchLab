---
name: image-optimizer
description: Image management for vakruska.lt. Use when adding new photos, converting formats, creating og-cover.jpg, or auditing img/ directory. Enforces WebP+JPG dual format, correct naming, alt text standards, and file size limits.
metadata:
  author: agent
  version: "1.0"
  created: 2026-02-27
  updated: 2026-02-27
---

# Image Optimizer Skill

## Purpose
Maintain a clean, performant, and SEO-optimized image library in `img/` following the project's dual-format (WebP + JPG) standard.

## Capabilities

- **Format audit**: Verify every image has both `.webp` and `.jpg` versions
- **Naming convention**: Enforce kebab-case, LT-descriptive filenames
- **Size limits**: Check file sizes stay within performance budget
- **og-cover.jpg**: Specifications and creation guidance
- **Alt text linking**: Connect image filenames to correct alt texts from SEO-PLANAS.md
- **HTML audit**: Verify `<img>` tags use WebP with JPG fallback pattern

## Operational Rules

- **ALWAYS** provide both `.webp` and `.jpg` for every new image
- **ALWAYS** use kebab-case filenames in Lithuanian/descriptive English
- **ALWAYS** update `<img>` tags in `index.php` when adding new images
- **ALWAYS** add appropriate LT alt text (see seo-optimizer skill)
- **NEVER** use spaces or uppercase in image filenames
- **NEVER** commit images above 500 KB without explicit approval
- **NEVER** use PNG format for photos (use WebP/JPG)
- **NEVER** delete an image without checking all `<img src="...">` references in `index.php`

## File Size Budget

| Type | Max size |
|------|----------|
| Regular photo (.webp) | 150 KB |
| Regular photo (.jpg fallback) | 300 KB |
| `og-cover.jpg` | 300 KB |
| Gallery thumbnail | 100 KB |

## `img/` Naming Convention

```
[subject]-[detail]-[context].webp
[subject]-[detail]-[context].jpg

Examples:
  sodyba-poilsiui-namelis-kaune.webp     ✓
  vistide-Quramo-Q6.webp                 ✓
  ogCover.jpg                            ✗ (camelCase)
  foto1.webp                             ✗ (not descriptive)
```

## og-cover.jpg Specifications (MISSING — needs to be created)

```
File:       img/og-cover.jpg
Dimensions: 1200 × 630 px (Facebook/LinkedIn requirement)
Format:     JPG (no WebP needed for OG)
Max size:   300 KB
Content:    MB Vakruška brand photo — homestead or Quramo coop
            Should include: recognizable location, brand feel
Style:      Dark background preferred (matches site aesthetic)
```

## HTML Pattern for New Images

```html
<!-- CORRECT — WebP with JPG fallback -->
<picture>
  <source srcset="img/filename.webp" type="image/webp">
  <img src="img/filename.jpg" alt="Aprašomasis LT alt tekstas" loading="lazy">
</picture>

<!-- ACCEPTABLE for simple cases -->
<img src="img/filename.webp" alt="Aprašomasis LT alt tekstas" loading="lazy"
     onerror="this.src='img/filename.jpg'">
```

## Tool Usage

### Audit: find images missing WebP pair
```powershell
$jpgs = Get-ChildItem img/ -Filter "*.jpg" | Select-Object -ExpandProperty BaseName
$webps = Get-ChildItem img/ -Filter "*.webp" | Select-Object -ExpandProperty BaseName
$jpgs | Where-Object { $_ -notin $webps }
```

### Audit: find images missing JPG pair
```powershell
$webps | Where-Object { $_ -notin $jpgs }
```

### Check file sizes over budget
```powershell
Get-ChildItem img/ | Where-Object { $_.Length -gt 512000 } | Select-Object Name, @{N='SizeKB';E={$_.Length -shr 10}}
```

### Find all img src references in index.php
```powershell
Select-String -Path index.php -Pattern 'src="img/' | Select-Object LineNumber, Line
```

### Check og-cover.jpg exists
```powershell
Test-Path "img/og-cover.jpg"
```

## Triggers
- "pridėti nuotrauką"
- "keisti paveikslėlį"
- "sukurti og-cover"
- "optimizuoti nuotraukas"
- "konvertuoti į webp"
- "patikrinti img"

## Error Handling

### Error: og-cover.jpg missing
**Symptom**: `Test-Path "img/og-cover.jpg"` returns `False`; social sharing shows no image
**Resolution**:
1. This is a known gap — inform user
2. Requirements: 1200×630 px, JPG, ≤300 KB
3. After file is created: upload to server via SFTP, verify with Open Graph debugger: https://developers.facebook.com/tools/debug/

### Error: Image file referenced in index.php but not in img/
**Symptom**: `Select-String` finds src reference but `Test-Path` returns False
**Resolution**:
1. Either add the missing image file to `img/`
2. Or remove/update the broken `<img>` reference in `index.php`
