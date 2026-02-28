---
name: project-scaffolder
description: Create a new StitchLab design project folder with all required files. Use when the user starts a new design project. Triggers: "naujas projektas", "new design project", "sukurk projektą", "pradėk dizaino projektą".
license: Apache-2.0
tags: [scaffold, project, setup]
metadata:
  author: StitchLab
  version: "1.0"
  created: 2026-02-28
  updated: 2026-02-28
---

# Project Scaffolder Skill

## Purpose
Create a new design project folder under `projects/` with all required structure,
then create a corresponding Google Stitch project via StitchMCP.

## Capabilities

- **Create project folder** with correct directory structure
- **Create Stitch project** via `mcp_StitchMCP_create_project`
- **Initialize `stitch.json`** with project metadata
- **Initialize `README.md`** with project brief

## Operational Rules

- **ALWAYS** ask user for: project name, device type, brief description if not provided
- **ALWAYS** use kebab-case for the project folder name
- **ALWAYS** create the Stitch project before writing `stitch.json`
- **ALWAYS** save the Stitch project ID immediately after creation
- **NEVER** overwrite an existing project folder without user confirmation

## Tool Usage

### Step 1: Gather information

Ask the user (if not already provided):
- Project name (e.g., "SaaS Dashboard", "E-commerce Landing")
- Device type: desktop / mobile / tablet
- Brief: What is this design for?

### Step 2: Create local folder structure

```
mcp_filesystem_create_directory("projects/[project-name]")
mcp_filesystem_create_directory("projects/[project-name]/screens")
mcp_filesystem_create_directory("projects/[project-name]/assets")
```

### Step 3: Create Stitch project

```json
mcp_StitchMCP_create_project({
  "title": "StitchLab — [Human Readable Project Name]"
})
```

Save the returned `projectId`.

### Step 4: Write stitch.json

```json
{
  "projectId": "RETURNED_PROJECT_ID",
  "projectName": "Human Readable Name",
  "created": "YYYY-MM-DD",
  "lastUpdated": "YYYY-MM-DD",
  "deviceType": "DESKTOP",
  "description": "3-5 sentence project brief",
  "status": "active",
  "screens": [],
  "tags": []
}
```

### Step 5: Write project README.md

Create `projects/[project-name]/README.md` with:
- Project name and description
- Device target
- Date created
- Key design decisions / constraints

### Step 6: Confirm to user

Report: project folder created, Stitch project ID, ready to generate screens.

## Triggers

- "naujas projektas" / "new project"
- "sukurk projektą" / "create project"
- "pradėk dizaino projektą" / "start design project"
- "inicializuok projektą"

## Error Handling

### Error: Stitch project creation fails
**Symptom**: `mcp_StitchMCP_create_project` returns an error
**Resolution**: Create the local folder anyway, set `projectId: null` in `stitch.json`, notify user that Stitch project must be created manually.
