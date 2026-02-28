---
name: design-reviewer
description: Review, iterate, and improve generated Stitch designs. Use when the user wants to change, refine, or create variants of an existing design. Triggers: "pakeisk dizainą", "iterate design", "peržiūrėk", "pataisyk", "sukurk variantus", "make it darker/lighter/better".
license: Apache-2.0
tags: [stitch, design, iteration, review, variants]
metadata:
  author: StitchLab
  version: "1.0"
  created: 2026-02-28
  updated: 2026-02-28
---

# Design Reviewer Skill

## Purpose
Review existing Stitch screens with the user, then iterate using edit or variant
generation to improve the design based on feedback.

## Capabilities

- **Describe current design** by retrieving and presenting screen details
- **Edit a screen** with targeted changes via `mcp_StitchMCP_edit_screens`
- **Generate variants** to explore alternative directions via `mcp_StitchMCP_generate_variants`
- **Compare options** by presenting multiple variants to the user

## Operational Rules

- **ALWAYS** present the current design description before proposing changes
- **ALWAYS** translate user feedback into a precise English prompt for Stitch
- **ALWAYS** ask user to confirm which variant to keep before updating `stitch.json`
- **NEVER** delete the original screen without user confirmation
- **NEVER** make vague edit prompts — be specific about what to change

## Tool Usage

### Editing an existing screen

```json
mcp_StitchMCP_edit_screens({
  "projectId": "PROJECT_ID",
  "selectedScreenIds": ["SCREEN_ID"],
  "prompt": "Change the background to dark navy (#0A0F1E). Make the cards use glassmorphism effect with subtle white borders. Replace the blue accent with purple (#7C3AED).",
  "deviceType": "DESKTOP",
  "modelId": "GEMINI_3_PRO"
})
```

### Generating variants

```json
mcp_StitchMCP_generate_variants({
  "projectId": "PROJECT_ID",
  "selectedScreenIds": ["SCREEN_ID"],
  "prompt": "Create variations of this dashboard with different color schemes",
  "variantOptions": {
    "count": 3,
    "creativeRange": "medium",
    "focusAspects": ["color", "typography", "layout"]
  },
  "deviceType": "DESKTOP",
  "modelId": "GEMINI_3_FLASH"
})
```

## Writing Good Edit Prompts

Translate user feedback precisely:

| User says | Good edit prompt |
|-----------|-----------------|
| "padaryk tamsiau" | "Switch to a dark theme with #0D1117 background and white text" |
| "moderniau" | "Apply glassmorphism cards, smooth gradients, and rounded-2xl corners throughout" |
| "paprasčiau" | "Remove decorative elements, use flat design, increase whitespace" |
| "pakeisk spalvas" | "Change accent color to [specific color]. Use a softer, more muted palette" |
| "kitoks layoutas" | "Rearrange: move sidebar to top as horizontal navbar, convert cards to a data table" |

## Review Process

1. Call `mcp_StitchMCP_get_screen` to retrieve current screen state
2. Describe the design to the user: layout, colors, typography
3. Ask: "Ką norėtumėte pakeisti?" (What would you like to change?)
4. Translate feedback to English prompt
5. Use `edit_screens` for targeted changes OR `generate_variants` for exploration
6. Present results, ask user to pick preferred version
7. Update `stitch.json` with the chosen screen ID

## Triggers

- "pakeisk dizainą" / "change design"
- "pataisyk" / "fix / improve"
- "peržiūrėk" / "review"
- "sukurk variantus" / "create variants"
- "iterate", "refine", "make it better"
- Any feedback about colors, layout, fonts, spacing

## Error Handling

### Error: Edit didn't apply correctly
**Symptom**: New screen looks same as before or change was minimal
**Resolution**: Write a more specific prompt targeting the exact element to change. Use CSS-level specificity in the prompt.

### Error: Variant generation returned only 1 variant
**Symptom**: Less variants than requested
**Resolution**: That's normal — Stitch may generate fewer. Present what was generated and offer to generate more.
