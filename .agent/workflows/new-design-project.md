---
description: Create a new StitchLab design project from scratch - scaffold folder, create Stitch project, and generate the first screen
---

# New Design Project Workflow

## Prerequisites
- StitchLab is the active workspace
- Agent has read PROJECT_SPEC.md and AGENTS.md

## Steps

### 1. Gather project details from user

Ask for (if not provided):
- Project name
- Target device: desktop / mobile / tablet
- Brief description: what is this design for?
- Style direction: dark/light, minimal/rich, any color preferences

### 2. Run project-scaffolder skill

// turbo
Read `.agent/skills/project-scaffolder/SKILL.md` and execute the scaffold workflow.
This creates:
- `projects/[project-name]/` folder
- `projects/[project-name]/screens/` subfolder
- `projects/[project-name]/assets/` subfolder
- `projects/[project-name]/stitch.json`
- `projects/[project-name]/README.md`
- Google Stitch project (get project ID)

### 3. Generate first screen

Run the `stitch-designer` skill to generate the first screen using the project brief.

Use `GEMINI_3_PRO` for the first screen to get the highest quality result.

### 4. Present result to user

Describe the generated design and ask:
- "Ar norėtumėte ką nors pakeisti?" (Would you like to change anything?)
- "Generuoti daugiau ekranų?" (Generate more screens?)
- "Eksportuoti?" (Export?)

### 5. Update TASKS.md

Mark the project as active in `TASKS.md`.
