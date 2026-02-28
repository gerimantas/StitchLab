---
name: stitch-designer
description: Generate web and web app UI screens using Google Stitch MCP. Use when the user asks to create a screen, design a page, generate UI, or build a layout. Triggers: "generuok ekraną", "sukurk dizainą", "design a screen", "create UI", "draw a page".
license: Apache-2.0
tags: [stitch, design, ui, ux, generation]
metadata:
  author: StitchLab
  version: "1.0"
  created: 2026-02-28
  updated: 2026-02-28
---

# Stitch Designer Skill

## Purpose
Generate professional web/web app UI screens from text prompts using the Google Stitch MCP.
This skill handles the full generation loop: project check → generate → retrieve → present.

## Capabilities

- **Generate screens**: Create new screens from text prompts in an existing Stitch project
- **List screens**: Show what screens already exist in a project
- **Retrieve screen details**: Get the generated screenshot and metadata
- **Create project**: Create a new Stitch project if none exists for this design task

## Operational Rules

- **ALWAYS** check `stitch.json` in the project folder before creating a new Stitch project
- **ALWAYS** read `PROJECT_SPEC.md §D` for device type and model selection guidelines
- **ALWAYS** write generation prompts in English for best Stitch results
- **ALWAYS** describe the generated design to the user after generation
- **ALWAYS** save the screen ID to `stitch.json` after successful generation
- **NEVER** retry generation more than once without user guidance (it takes time)
- **NEVER** make up screen IDs — always get them from the MCP response

## Tool Usage

### Step 1: Check for existing Stitch project

Read the project's `stitch.json`:
```
mcp_filesystem_read_file("projects/[project-name]/stitch.json")
```

If no project exists → run `project-scaffolder` skill first.

### Step 2: Generate a screen

```json
mcp_StitchMCP_generate_screen_from_text({
  "projectId": "PROJECT_ID_FROM_STITCH_JSON",
  "prompt": "Modern SaaS dashboard with dark mode, sidebar navigation, KPI cards, and a data table. Use Inter font, purple accent color.",
  "deviceType": "DESKTOP",
  "modelId": "GEMINI_3_PRO"
})
```

**Wait for the result.** This can take 1-3 minutes.

### Step 3: Retrieve and present the screen

```json
mcp_StitchMCP_get_screen({
  "name": "projects/PROJECT_ID/screens/SCREEN_ID",
  "projectId": "PROJECT_ID",
  "screenId": "SCREEN_ID"
})
```

Present the result to the user with a description of the visual layout.

### Step 4: Update stitch.json

Add the new screen to the `screens` array in `stitch.json`.

## Prompt Engineering Guide

Write prompts that specify:
1. **Style**: dark/light, glassmorphism, minimal, brutalist, etc.
2. **Layout**: sidebar, top-nav, card grid, data table, etc.
3. **Color**: accent color, background color palette
4. **Typography**: preferred font family
5. **Content**: what sections/components to include

**Good prompt example:**
```
Landing page for a B2B SaaS project management tool. Clean white background,
blue-purple gradient hero section, feature cards with icons, testimonials section,
and pricing table. Use Inter font. Modern, professional aesthetic.
```

## Triggers

- "generuok ekraną" / "generate screen"
- "sukurk dizainą" / "create design"
- "dizainuok puslapį" / "design a page"
- "padaryk UI" / "make UI"
- "stitch ekranas" / "stitch screen"

## Error Handling

### Error: Generation timeout
**Symptom**: Tool call hangs or returns connection error
**Resolution**: Wait 2 minutes, then call `mcp_StitchMCP_get_screen` with the screen ID if you received one. If no ID received, retry once.

### Error: Screen not found
**Symptom**: `get_screen` returns 404 or not found
**Resolution**: Call `mcp_StitchMCP_list_screens` with `projectId` to verify available screens.

### Error: Project not found
**Symptom**: API returns project doesn't exist
**Resolution**: Call `mcp_StitchMCP_list_projects` to find the correct project ID and update `stitch.json`.
