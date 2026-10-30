# DevOpt installer for Windows PowerShell
#   irm https://devopt.udithsandaruwan.com/install.ps1 | iex

$ErrorActionPreference = "Stop"
$Repo = if ($env:DEVOPT_REPO) { $env:DEVOPT_REPO } else { "udithsandaruwan2/devopt-framework" }
$Branch = if ($env:DEVOPT_BRANCH) { $env:DEVOPT_BRANCH } else { "main" }
$ZipUrl = "https://github.com/$Repo/archive/refs/heads/$Branch.zip"

Write-Host ""
Write-Host "  DevOpt installer"
Write-Host "  https://devopt.udithsandaruwan.com"
Write-Host ""

$Name = Read-Host "Project name [my-app]"
if ([string]::IsNullOrWhiteSpace($Name)) { $Name = "my-app" }

$DirDefault = Join-Path (Get-Location) $Name
$Target = Read-Host "Directory [$DirDefault]"
if ([string]::IsNullOrWhiteSpace($Target)) { $Target = $DirDefault }

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

$GitPick = Read-Host "Git model: 1) promotion tracks  2) trunk [1]"
$Trunk = ($GitPick -eq "2")

if (Test-Path $Target) {
  if ((Get-ChildItem $Target -Force | Measure-Object).Count -gt 0) {
    throw "Directory exists and is not empty: $Target"
  }
} else {
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
  & bash @args
} finally {
  Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "Done. cd $Target"
Write-Host "Open the folder in your AI agent and say:"
Write-Host "  Read AGENTS.md and project/STATE.md. Run project-kickoff for phase 0."
