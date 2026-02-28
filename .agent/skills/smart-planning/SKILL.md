---
name: smart-planning
description: Use for ANY multi-step task, research, or complex implementation. This is the master cognitive framework replacing all older planning skills. It manages Analysis, Technical Planning, and Execution in one unified workflow.
tags: [core, master, planning, execution, workflow]
---

# Smart Planning (The Unified Framework)

## Overview
`smart-planning` is the core architectural engine. It unifies Manus-style persistent memory (thinking in files), strict TDD-style step formulation, and safe batch execution into a single, cohesive workflow.

**Core Principle:** "Context Window = RAM (volatile, limited). Filesystem = Disk (persistent, unlimited). Everything important goes to Disk."

**Announce at start:** "Naudoju `smart-planning` įgūdį šios užduoties organizavimui ir vykdymui."

---

## The 3-Phase Workflow

### Phase 1: Analysis & Decision (The "Dual-Speed" Router)
Before writing any code, determine the nature of the task:

- **Scenario A: Task is exploratory / undocumented (R&D).**
    - **Domain Brain Research:** If the task involves Quramo products, specs, or client domain knowledge, **MANDATORY**: Query the **"Quramo" Notebook** using the `notebook_id` from `.agent/config.json` first.
    - Create `docs/plans/findings.md` to dump research findings (Domain Brain), API responses, and file structures.
    - Create `docs/plans/task_plan.md` for high-level phase tracking (Manus style).
    - *Action:* Use the **Quramo Notebook** as the "Domain Brain" and local context as the "Execution Brain". Once research is documented, proceed to Phase 2.
- **Scenario B: Task is clear / standard implementation (e.g. UI update, adding a field).**
    - Skip the exploratory files.
    - *Action:* Proceed IMMEDIATELY to Phase 2.

### Phase 2: Technical Planning (The Blueprint)
Create a strict, bite-sized implementation plan at `docs/plans/YYYY-MM-DD-<feature-name>.md`. 
**Assume the executing session has zero context.** Write exact file paths, exact code blocks to change, and exact commands to run.

**Document Header Format:**
```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence what this builds]
**Architecture:** [2-3 sentences]
```

**Task Structure (Bite-Sized):**
```markdown
### Task 1: [Component Name]
**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`

**Step 1: Write/Update Code** (Provide exact diff or function replacement)
**Step 2: Verification** (Provide exact command: `npm run build` or `pytest ...`)
**Step 3: Commit** (Command: `git commit -am "feat: added X"`)
```
*Note: DRY, YAGNI, TDD principles apply.*

### Phase 3: Batch Execution (Action)
Once the plan is written (and approved by the user if it's a major change):
1. **Auto-Checkpoint:** RUN `git add . && git commit -m "chore: auto-checkpoint before <feature>"` IF the working tree is dirty. (Safety first!)
2. **Execute in Batches:** Do not execute 10 tasks at once. Process 2-4 tasks strictly, verifying each step as written in the plan.
3. **Report:** Stop execution, summarize what was achieved (e.g. "Baigta 1 Partija (UI struktūra)"), present the result to the user, and ask for permission to proceed to the next batch.

---

## When to Stop and Escalate
The Agent MUST stop and notify the user immediately if:
1. **The 3-Strike Error Protocol fails:** You tried to fix an error 3 different ways during execution and it still fails. Do not guess. Do not loop. Escalate.
2. **Missing Dependencies:** The plan relies on a tool/library that doesn't exist and you don't have permission to install it.
3. **Ambiguous Instructions:** The user's prompt contradicts existing rules in `gemini.md`.

## Summary of Deprecated Skills
This skill completely replaces and obsoletes:
- `planning-with-files`
- `writing-plans`
- `executing-plans`
Do not use them. Use `smart-planning`.
