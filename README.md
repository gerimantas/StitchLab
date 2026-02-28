# StitchLab

> **Web & Web App Design Studio** — powered by Antigravity AI + Google Stitch

StitchLab is an AI-driven design workspace for generating, iterating, and managing
web and web app UI designs using Google Stitch (stitch.withgoogle.com) and the
Antigravity agentic coding assistant.

---

## What It Does

- **Generate** UI screens from text prompts using Google Stitch
- **Iterate** on designs with AI-powered edits and variants
- **Export** screens as local HTML/CSS files for integration
- **Build** complete multi-page websites autonomously via stitch-loop
- **Convert** Stitch designs to React/Vite components
- **Organize** design projects with structured metadata

---

## Tech Stack

| Layer | Tool |
|-------|------|
| AI Agent | Antigravity |
| Design Generation | Google Stitch (StitchMCP) |
| Local Files | HTML + Vanilla CSS + JS |
| Complex Web Apps | Next.js / Vite |
| Asset Generation | Antigravity `generate_image` |

---

## Design Workflow

```
enhance-prompt → stitch-designer → design-md → stitch-loop → react-components
     ↓                 ↓               ↓              ↓               ↓
 Polish prompt    Generate screens  DESIGN.md   Build all pages  React export
```

## Project Structure

```
projects/         ← Design projects (one folder per project)
  [name]/
    stitch.json   ← Stitch project ID + screen IDs (SSoT)
    DESIGN.md     ← Generated design system
    SITE.md       ← Site constitution (stitch-loop projects)
    screens/      ← Exported HTML screens
exports/          ← Flat ready-to-use exports
assets/           ← Shared assets (logos, palettes)
docs/             ← Design system, palette library
.agent/
  skills/         ← 11 skills (4 official Google + 7 StitchLab)
  workflows/      ← new-design-project, generate-screen, export-and-preview
  scripts/        ← update-registry.ps1, open-preview.ps1
```

---

## Skills

| Skill | Source | Purpose |
|-------|--------|---------|
| `enhance-prompt` | Google | Optimize prompts before generation |
| `design-md` | Google | Generate DESIGN.md design system |
| `stitch-loop` | Google | Autonomous multi-page builder |
| `react-components` | Google | Stitch → Vite/React converter |
| `stitch-designer` | StitchLab | Generate screens via StitchMCP |
| `stitch-exporter` | StitchLab | Export designs to local HTML |
| `design-reviewer` | StitchLab | Iterate and improve designs |
| `project-scaffolder` | StitchLab | New project setup wizard |
| `smart-planning` | StitchLab | Complex task planning |
| `git-basics` | StitchLab | Safe git operations |
| `image-optimizer` | StitchLab | Image asset optimization |

---

## Quick Start

1. Open StitchLab in VS Code
2. Start a conversation with Antigravity
3. Say: **"Sukurk naują dizaino projektą"** — starts the `new-design-project` workflow
4. Antigravity will scaffold the project and generate the first screen

---

## Links

- [Google Stitch](https://stitch.withgoogle.com/)
- [google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills)
- [Project Spec](PROJECT_SPEC.md)
- [Agent Rules](AGENTS.md)
