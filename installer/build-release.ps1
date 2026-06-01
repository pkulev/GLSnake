# Build portable ZIP and MSI from an existing Meson build/ directory.
param(
    [Parameter(Mandatory = $true)]
    [string] $Version,

    [string] $BuildDir = "build",
    [string] $DistDir = "dist"
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

if ($Version -match '^v') {
    $Version = $Version.Substring(1)
}

# MSI requires four version components.
$msiVersion = if ($Version -match '^\d+\.\d+\.\d+$') {
    "$Version.0"
} elseif ($Version -match '^\d+\.\d+\.\d+\.\d+$') {
    $Version
} else {
    throw "Unsupported version format: $Version (expected v1.2.3 or 1.2.3.4)"
}

$tag = $Version -replace '\.', '_'

& (Join-Path $PSScriptRoot "stage-windows.ps1") -BuildDir $BuildDir -StageDir (Join-Path $PSScriptRoot "staging")

$distPath = Join-Path $repoRoot $DistDir
New-Item -ItemType Directory -Force -Path $distPath | Out-Null

$zipName = "GLSnake-$Version-win64.zip"
$zipPath = Join-Path $distPath $zipName
if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}
Compress-Archive -Path (Join-Path $PSScriptRoot "staging\*") -DestinationPath $zipPath
Write-Host "Created $zipPath"

Push-Location $PSScriptRoot
try {
    dotnet build "GLSnake.Installer.wixproj" `
        -c Release `
        -p:Version=$msiVersion `
        -p:StagingDir="$(Join-Path $PSScriptRoot 'staging')"
    if ($LASTEXITCODE -ne 0) {
        throw "WiX build failed with exit code $LASTEXITCODE"
    }
}
finally {
    Pop-Location
}

$msiBuilt = Get-ChildItem -Path (Join-Path $PSScriptRoot "bin") -Filter "GLSnake.msi" -Recurse -File |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1
if (-not $msiBuilt) {
    throw "GLSnake.msi not found under installer/bin after WiX build"
}

$msiName = "GLSnake-$Version-win64.msi"
$msiPath = Join-Path $distPath $msiName
Copy-Item -LiteralPath $msiBuilt.FullName -Destination $msiPath -Force
Write-Host "Created $msiPath"
