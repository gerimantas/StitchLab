<#
.SYNOPSIS
    Updates .agent/skills/registry.json from SKILL.md files.

.DESCRIPTION
    Scans all SKILL.md files in .agent/skills/*/SKILL.md,
    extracts name, description and triggers from YAML frontmatter,
    and rewrites registry.json.

.PARAMETER SkillsDir
    Path to skills folder. Default: .agent/skills (relative to project root)

.PARAMETER DryRun
    Shows what would change without writing the file.

.EXAMPLE
    .\.agent\scripts\update-registry.ps1
    .\.agent\scripts\update-registry.ps1 -DryRun
#>

param(
    [string]$SkillsDir = "",
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Paths ─────────────────────────────────────────────────────────────────────

# $PSScriptRoot = folder of this script (.agent/scripts)
$AgentDir = Split-Path -Parent $PSScriptRoot   # → .agent/

if (-not $SkillsDir) {
    $SkillsDir = Join-Path $AgentDir "skills"
}
$SkillsDir = Resolve-Path $SkillsDir
$RegistryPath = Join-Path $SkillsDir "registry.json"

Write-Host ""
Write-Host "StitchLab Registry Updater" -ForegroundColor Cyan
Write-Host "  Skills dir : $SkillsDir" -ForegroundColor Gray
Write-Host "  Registry   : $RegistryPath" -ForegroundColor Gray
if ($DryRun) {
    Write-Host "  Mode       : DRY RUN" -ForegroundColor Yellow
}
Write-Host ""

# ── Helpers ───────────────────────────────────────────────────────────────────

function Read-FrontmatterValue([string[]]$Lines, [string]$Key) {
    foreach ($line in $Lines) {
        if ($line -match "^${Key}:\s*(.+)$") {
            return $Matches[1].Trim().Trim('"')
        }
    }
    return $null
}

function Read-FrontmatterTriggers([string[]]$Lines) {
    # Inline array: triggers: ["a", "b"]
    foreach ($line in $Lines) {
        if ($line -match '^triggers:\s*\[(.+)\]') {
            $raw = $Matches[1]
            return @(($raw -split ',') |
                ForEach-Object { $_.Trim().Trim('"').Trim("'") } |
                Where-Object { $_ -ne "" })
        }
    }
    # Block list:
    # triggers:
    #   - "a"
    $inTriggers = $false
    $triggers = [System.Collections.Generic.List[string]]::new()
    foreach ($line in $Lines) {
        if ($line -match '^triggers:\s*$') { $inTriggers = $true; continue }
        if ($inTriggers -and $line -match '^\s+-\s+"?(.+?)"?\s*$') {
            $triggers.Add($Matches[1].Trim()) | Out-Null
        }
        elseif ($inTriggers -and $line -notmatch '^\s+-') {
            break
        }
    }
    return $triggers.ToArray()
}

function Read-SkillFile([string]$FilePath) {
    $lines = Get-Content $FilePath -Encoding UTF8

    # Find YAML frontmatter between --- markers
    $fmStart = -1; $fmEnd = -1
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -eq "---") {
            if ($fmStart -eq -1) { $fmStart = $i + 1 }
            elseif ($fmEnd -eq -1) { $fmEnd = $i - 1; break }
        }
    }

    if ($fmStart -eq -1 -or $fmEnd -eq -1) {
        Write-Warning "  No frontmatter found: $FilePath"
        return $null
    }

    $fmLines = $lines[$fmStart..$fmEnd]
    $name = Read-FrontmatterValue $fmLines "name"
    $description = Read-FrontmatterValue $fmLines "description"
    $triggers = Read-FrontmatterTriggers $fmLines

    # Fallback: extract triggers from ## Triggers section in body
    if (-not $triggers -or $triggers.Count -eq 0) {
        $inSection = $false
        $fallback = [System.Collections.Generic.List[string]]::new()
        foreach ($line in $lines) {
            if ($line -match '^##\s+Triggers') { $inSection = $true; continue }
            if ($inSection -and $line -match '^##') { break }
            if ($inSection -and $line -match '^-\s+"?(.+?)"?\s*(\(.*\))?\s*$') {
                $val = $Matches[1].Trim().Trim('"')
                # Skip lines that look like labels "(e.g. ...)"
                if ($val -notmatch '^e\.g\.' -and $val.Length -lt 60) {
                    $fallback.Add($val) | Out-Null
                }
            }
        }
        $triggers = $fallback.ToArray()
    }

    # Fallback name from folder name
    if (-not $name) {
        $name = Split-Path (Split-Path $FilePath -Parent) -Leaf
        Write-Warning "  No 'name' in frontmatter, using folder name: $name"
    }

    return [pscustomobject]@{
        name        = $name
        path        = ".agent/skills/$name/SKILL.md"
        description = if ($description) { $description } else { "" }
        triggers    = @($triggers | Select-Object -Unique)
    }
}

# ── Main ──────────────────────────────────────────────────────────────────────

if (-not (Test-Path $SkillsDir)) {
    Write-Error "Skills folder not found: $SkillsDir"
    exit 1
}

# Scan only direct child folders: .agent/skills/[skill-name]/SKILL.md (depth = 1)
$skillFiles = Get-ChildItem -Path $SkillsDir -Directory |
Where-Object { $_.Name -notmatch '^_' } |
ForEach-Object {
    $candidate = Join-Path $_.FullName "SKILL.md"
    if (Test-Path $candidate) { Get-Item $candidate }
} |
Sort-Object FullName

if ($skillFiles.Count -eq 0) {
    Write-Host "No SKILL.md files found." -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($skillFiles.Count) skill(s):" -ForegroundColor White
Write-Host ""

$skills = [System.Collections.Generic.List[object]]::new()

foreach ($file in $skillFiles) {
    $parsed = Read-SkillFile -FilePath $file.FullName
    if ($null -eq $parsed) { continue }

    $desc = $parsed.description
    if ($desc.Length -gt 65) { $desc = $desc.Substring(0, 65) + "..." }

    Write-Host "  [OK] $($parsed.name)" -ForegroundColor Green
    Write-Host "       desc     : $desc" -ForegroundColor Gray
    Write-Host "       triggers : $($parsed.triggers.Count) found" -ForegroundColor Gray
    $skills.Add($parsed) | Out-Null
}

Write-Host ""

# Build registry
$dateNow = Get-Date -Format "yyyy-MM-dd"
$registry = [pscustomobject]@{
    lastUpdated = $dateNow
    totalSkills = $skills.Count
    skills      = $skills.ToArray()
}

$json = $registry | ConvertTo-Json -Depth 10

if ($DryRun) {
    Write-Host "── DRY RUN output ──────────────────────────────────" -ForegroundColor Yellow
    Write-Host $json
    Write-Host "────────────────────────────────────────────────────" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "DryRun: file NOT written." -ForegroundColor Yellow
}
else {
    $json | Set-Content -Path $RegistryPath -Encoding UTF8
    Write-Host "[OK] Registry updated: $RegistryPath" -ForegroundColor Green
    Write-Host "     Skills written : $($skills.Count)" -ForegroundColor Gray
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm"
    Write-Host "     Timestamp      : $ts" -ForegroundColor Gray
}

Write-Host ""
