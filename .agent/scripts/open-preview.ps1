# Open preview script
param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

$absolutePath = Resolve-Path $FilePath -ErrorAction SilentlyContinue
if (-not $absolutePath) {
    Write-Error "File not found: $FilePath"
    exit 1
}

Write-Host "Opening preview: $absolutePath" -ForegroundColor Cyan
Start-Process $absolutePath.ToString()
Write-Host "Preview opened in default browser." -ForegroundColor Green
