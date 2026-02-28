---
description: Export a Stitch screen locally and open a preview in the browser
---

# Export and Preview Workflow

## Prerequisites
- A Stitch screen has been generated (screen ID exists in stitch.json)

## Steps

### 1. Identify screen to export

Ask user: "Kurį ekraną eksportuoti?" (Which screen to export?)

Read `stitch.json` to show available screens with their names.

### 2. Run stitch-exporter skill

// turbo
Read `.agent/skills/stitch-exporter/SKILL.md` and execute the export steps.

### 3. Check exported file

Verify the file was created at `projects/[name]/screens/[screen-name].html`

### 4. Open preview (optional)

If user wants to preview, run:
```powershell
Start-Process "projects/[name]/screens/[screen-name].html"
```

Or use the script:
```powershell
.agent/scripts/open-preview.ps1 -FilePath "projects/[name]/screens/[screen-name].html"
```

### 5. Offer integration

Ask user:
- "Nori integruoti į Next.js/Vite projektą?"
- "Nukopijuoti į kito projekto aplanką?"
- "Generuoti dar vieną ekraną?"
