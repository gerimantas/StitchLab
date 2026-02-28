---
description: Generate one or more screens using Google Stitch for an existing project
---

# Generate Screen Workflow

## Prerequisites
- A project folder exists under `projects/`
- `stitch.json` exists with a valid `projectId`

## Steps

### 1. Identify project

Check what the user wants:
- For which project?
- What screen/page to generate?
- Any specific design directions?

If no project exists yet → switch to `new-design-project` workflow.

### 2. Read project context

Read `projects/[project-name]/stitch.json` to get the `projectId` and existing screens.

### 3. Read stitch-designer skill

// turbo
Read `.agent/skills/stitch-designer/SKILL.md` and execute the generation steps.

### 4. Generate the screen

Write an English prompt following the Prompt Engineering Guide in the skill.

Include:
- Style (dark/light, aesthetic direction)
- Layout (navigation type, grid, sections)
- Colors (accent, background)
- Typography (font preference)
- Content (what sections to include)

Call `mcp_StitchMCP_generate_screen_from_text`.

### 5. Retrieve and present result

Call `mcp_StitchMCP_get_screen` with the returned screen ID.

Present to user:
- Visual description of what was generated
- Ask for feedback or adjustments

### 6. Update stitch.json

Add the new screen to the `screens` array with:
- `screenId`
- `name`
- `prompt` (the exact prompt used)
- `lastUpdated` (today's date)

### 7. Offer next steps

- Iterate/edit → `design-reviewer` skill
- Export → `stitch-exporter` skill
- Generate more screens → repeat from step 3
