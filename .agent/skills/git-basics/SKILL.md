---
name: git-basics
description: Essential Git operations for version control and VibeCoding safety. Enforces Auto-Checkpointing.
tags: [git, version-control, safety, vibe-coding]
---

# Git Basics Skill

## Purpose
To provide standard Git capabilities (`init`, `add`, `commit`, `status`) and enforce the **Auto-Checkpoint** protocol. This ensures that every significant VibeCoding session has a "Save Point" (commit) to revert to if things go wrong.

## Capabilities

### 1. Auto-Checkpoint (`git_checkpoint`)
- **Tool**: `run_command`
- **Protocol**:
    1.  `git add .`
    2.  `git commit -m "Auto-Checkpoint: [Task Description]"`
- **When to use**: Call this **BEFORE** starting any complex "VibeCoding" task (e.g., refactoring, new feature) if the working tree is not clean.

### 2. Standard Operations
- **Init**: `git init` (Use only once at project start)
- **Status**: `git status` (Check before and after commits)
- **Log**: `git log --oneline -n 5` (Verify history)

## Operational Rules

1.  **Commit Often**: VibeCoding is fast and experimental. Commit small, working chunks.
2.  **Check Status First**: Always run `git status` before `git add .` to ensure you aren't committing unwanted files (check `.gitignore`).
3.  **Meaningful Messages**: Even for auto-checkpoints, try to add a brief context (e.g., `Auto-Checkpoint: pre-refactor`).

## Tool Usage Examples

### Scenario: Starting a new task
1.  **Check**: `run_command(command="git status")`
2.  **Checkpoint**: `run_command(command="git add . && git commit -m 'Save before generic refactor'")`

### Scenario: Saving progress
1.  **Save**: `run_command(command="git commit -am 'Implemented login header'")`
