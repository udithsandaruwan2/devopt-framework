# DevOpt installer for Windows PowerShell
#   irm https://devopt.udithsandaruwan.com/install.ps1 | iex
#   iex "& { $(irm https://devopt.udithsandaruwan.com/install.ps1) } -Here -Yes"
param(
  [string]$Name = "",
  [string]$Dir = "",
  [ValidateSet("django", "fastapi", "nest", "")]
  [string]$Backend = "",
  [switch]$Trunk,
  [switch]$Here,
  [switch]$Yes
)

$ErrorActionPreference = "Stop"
$Repo = if ($env:DEVOPT_REPO) { $env:DEVOPT_REPO } else { "udithsandaruwan2/devopt-framework" }
$Branch = if ($env:DEVOPT_BRANCH) { $env:DEVOPT_BRANCH } else { "main" }
$ZipUrl = "https://github.com/$Repo/archive/refs/heads/$Branch.zip"

function Test-Ignorable($name) {
  return $name -in @(".git", ".cursor", ".vscode", ".idea", ".DS_Store", ".claude", ".windsurf")
}

function Test-HasRealEntries($path) {
  if (-not (Test-Path $path)) { return $false }
  Get-ChildItem $path -Force | Where-Object { -not (Test-Ignorable $_.Name) } | Select-Object -First 1
}

Write-Host ""
Write-Host "  DevOpt installer"
Write-Host "  https://devopt.udithsandaruwan.com"
Write-Host ""

if ($Here) {
  if ([string]::IsNullOrWhiteSpace($Dir)) { $Dir = (Get-Location).Path }
  if ([string]::IsNullOrWhiteSpace($Name)) {
    $Name = Split-Path -Leaf (Get-Location)
    if ([string]::IsNullOrWhiteSpace($Name) -or $Name -eq "\" -or $Name -eq "/") { $Name = "my-app" }
  }
}

if ([string]::IsNullOrWhiteSpace($Name)) {
  if ($Yes) { $Name = "my-app" }
  else {
    $Name = Read-Host "Project name [my-app]"
    if ([string]::IsNullOrWhiteSpace($Name)) { $Name = "my-app" }
  }
}

$DirDefault = if ($Here) { (Get-Location).Path } else { Join-Path (Get-Location) $Name }
if ([string]::IsNullOrWhiteSpace($Dir)) {
  if ($Yes) { $Dir = $DirDefault }
  else {
    $TargetIn = Read-Host "Directory [$DirDefault]"
    $Dir = if ([string]::IsNullOrWhiteSpace($TargetIn)) { $DirDefault } else { $TargetIn }
  }
}
$Target = $Dir

if ([string]::IsNullOrWhiteSpace($Backend)) {
  if ($Yes) { $Backend = "django" }
  else {
    Write-Host ""
    Write-Host "Backend stack:"
    Write-Host "  1) Django + DRF  (default)"
    Write-Host "  2) FastAPI"
    Write-Host "  3) NestJS"
    $BackendPick = Read-Host "Choose 1/2/3 [1]"
    switch ($BackendPick) {
      "2" { $Backend = "fastapi" }
      "3" { $Backend = "nest" }
      default { $Backend = "django" }
    }
  }
}

if (-not $Trunk -and -not $Yes) {
  $GitPick = Read-Host "Git model: 1) promotion tracks  2) trunk [1]"
  $Trunk = ($GitPick -eq "2")
}

if (Test-HasRealEntries $Target) {
  throw "Directory exists and is not empty: $Target"
}
if (-not (Test-Path $Target)) {
  New-Item -ItemType Directory -Path $Target | Out-Null
}

$Tmp = Join-Path $env:TEMP ("devopt-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $Tmp | Out-Null
try {
  $Zip = Join-Path $Tmp "devopt.zip"
  Write-Host "Downloading $Repo@$Branch …"
  Invoke-WebRequest -Uri $ZipUrl -OutFile $Zip
  Expand-Archive -Path $Zip -DestinationPath $Tmp
  $Src = Get-ChildItem $Tmp -Directory | Select-Object -First 1
  if (-not (Test-Path (Join-Path $Src.FullName "scripts/bootstrap.sh"))) {
    throw "Archive did not contain scripts/bootstrap.sh. Use Git Bash or WSL to run install.sh."
  }

  $bash = Get-Command bash -ErrorAction SilentlyContinue
  if (-not $bash) {
    Write-Host ""
    Write-Host "Git Bash or WSL is required to run bootstrap.sh on Windows."
    Write-Host "Files were downloaded to: $($Src.FullName)"
    Write-Host "Install Git for Windows, then:"
    Write-Host "  bash $($Src.FullName)/scripts/bootstrap.sh `"$Target`" `"$Name`""
    exit 1
  }

  $args = @("$($Src.FullName)/scripts/bootstrap.sh", $Target, $Name)
  if ($Backend -eq "nest") { $args += "--backend-nest" }
  if ($Backend -eq "fastapi") { $args += "--backend-fastapi" }
  if ($Trunk) { $args += "--trunk" }
  if (-not (Test-HasRealEntries $Target) -and (Test-Path $Target) -and (Get-ChildItem $Target -Force | Select-Object -First 1)) {
    $args += "--force"
  }
  & bash @args
} finally {
  Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "Done. Path: $Target"
Write-Host "Open the folder in your AI agent and paste:"
Write-Host "  https://devopt.udithsandaruwan.com/prompt.txt"
