# Stage snake.exe, vcpkg DLLs, and resources/ for packaging.
param(
    [string] $BuildDir = "build",
    [string] $StageDir = "$PSScriptRoot/staging"
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

$exe = Join-Path $repoRoot $BuildDir "snake.exe"
if (-not (Test-Path -LiteralPath $exe)) {
    throw "Missing $exe — run meson compile first."
}

if (Test-Path -LiteralPath $StageDir) {
    Remove-Item -LiteralPath $StageDir -Recurse -Force
}
New-Item -ItemType Directory -Path $StageDir | Out-Null

Copy-Item -LiteralPath $exe -Destination $StageDir
Copy-Item -LiteralPath (Join-Path $repoRoot $BuildDir "*.dll") -Destination $StageDir

$resources = Join-Path $repoRoot "resources"
if (-not (Test-Path -LiteralPath $resources)) {
    throw "Missing resources directory at $resources"
}
Copy-Item -LiteralPath $resources -Destination (Join-Path $StageDir "resources") -Recurse

Write-Host "Staged Windows release files in $StageDir"
