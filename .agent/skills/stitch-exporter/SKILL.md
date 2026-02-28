---
name: stitch-exporter
description: Save and export Stitch-generated screens as local HTML files. Use when the user wants to download, export, or save a generated design locally. Triggers: "eksportuok", "išsaugok dizainą", "export design", "save screen", "atsisiųsk dizainą".
license: Apache-2.0
tags: [stitch, export, html, local]
metadata:
  author: StitchLab
  version: "1.0"
  created: 2026-02-28
  updated: 2026-02-28
---

# Stitch Exporter Skill

## Purpose
Retrieve the screenshot/output URL from a generated Stitch screen and save it
locally inside the project's `screens/` folder.

## Capabilities

- **Fetch screen data** from Stitch via `mcp_StitchMCP_get_screen`
- **Save exported HTML** to `projects/[name]/screens/`
- **Update `stitch.json`** with the local file reference
- **Open preview** in browser via PowerShell script

## Operational Rules

- **ALWAYS** confirm the screen exists in `stitch.json` before exporting
- **ALWAYS** use kebab-case filenames for exported files
- **ALWAYS** update `exportedFile` field in `stitch.json` after saving
- **NEVER** overwrite an existing export without user confirmation

## Tool Usage

### Step 1: Get screen details

```json
mcp_StitchMCP_get_screen({
  "name": "projects/PROJECT_ID/screens/SCREEN_ID",
  "projectId": "PROJECT_ID",
  "screenId": "SCREEN_ID"
})
```

### Step 2: Extract screenshot URL from response

Look for the screenshot/preview URL in the screen response object.

### Step 3: Save locally

If the response contains HTML code, write it directly:
```
mcp_filesystem_write_file("projects/[project-name]/screens/[screen-name].html", content)
```

### Step 4: Update stitch.json

Set `exportedFile` for the screen:
```json
"exportedFile": "screens/[screen-name].html"
```

### Step 5: Offer to preview

Ask user if they want to open the exported file in browser.
Use `.agent/scripts/open-preview.ps1` if available.

## Triggers

- "eksportuok" / "export"
- "išsaugok dizainą" / "save design"
- "atsisiųsk ekraną" / "download screen"
- "išsaugok lokaliai" / "save locally"

## Error Handling

### Error: No exportable content
**Symptom**: Screen response doesn't contain HTML or download URL
**Resolution**: Inform user that the design may need to be regenerated, or access it at stitch.withgoogle.com manually.
