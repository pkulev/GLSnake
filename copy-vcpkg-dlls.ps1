# Copy vcpkg runtime DLLs next to snake.exe in the Meson build directory.
param(
    [Parameter(Mandatory = $true)]
    [string] $VcpkgBin,

    [Parameter(Mandatory = $true)]
    [string] $DestDir,

    [Parameter(Mandatory = $false)]
    [string] $Stamp
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $VcpkgBin -PathType Container)) {
    Write-Error "vcpkg bin directory not found: $VcpkgBin"
    exit 1
}

New-Item -ItemType Directory -Force -Path $DestDir | Out-Null

Get-ChildItem -LiteralPath $VcpkgBin -Filter '*.dll' -File |
    Sort-Object Name |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $DestDir $_.Name) -Force
    }

if ($Stamp) {
    Set-Content -LiteralPath $Stamp -Value "copied`n" -Encoding ascii -NoNewline
}

exit 0
