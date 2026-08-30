[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$expectedProbeDirectory = [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot 'build\stage0-probe-data'))
$expectedLogsDirectory = [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot 'build\stage0-logs'))

if ($expectedProbeDirectory -ne (Join-Path $workspaceRoot 'build\stage0-probe-data')) {
  throw 'Refusing to use a probe directory outside this worktree.'
}

New-Item -ItemType Directory -Force -Path $expectedLogsDirectory | Out-Null
if (Test-Path -LiteralPath $expectedProbeDirectory) {
  Remove-Item -LiteralPath $expectedProbeDirectory -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $expectedProbeDirectory | Out-Null

$flutter = 'D:\Archer\LifeOS-stage0-tools\flutter\bin\flutter.bat'
if (-not (Test-Path -LiteralPath $flutter)) {
  throw "Pinned Flutter executable not found: $flutter"
}
$pubCache = 'D:\Archer\LifeOS-stage0-tools\pub-cache'
if (-not (Test-Path -LiteralPath $pubCache)) {
  New-Item -ItemType Directory -Force -Path $pubCache | Out-Null
}
$env:PUB_CACHE = $pubCache
if ($env:PUB_CACHE -ne $pubCache) {
  throw 'Unable to set the pinned D: PUB_CACHE path.'
}

Push-Location $workspaceRoot
try {
  & $flutter pub get
  if ($LASTEXITCODE -ne 0) { throw 'flutter pub get failed.' }

  & $flutter build windows --release
  if ($LASTEXITCODE -ne 0) { throw 'flutter build windows --release failed.' }

  $env:LIFEOS_STAGE0_HEADLESS = '1'
  $env:LIFEOS_STAGE0_DATA_DIR = $expectedProbeDirectory
  $executable = Join-Path $workspaceRoot 'build\windows\x64\runner\Release\lifeos_stage0_spike.exe'
  if (-not (Test-Path -LiteralPath $executable)) {
    throw "Expected Windows executable not found: $executable"
  }
  $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $runtimeLog = Join-Path $expectedLogsDirectory "windows-probe-$timestamp.log"
  $jsonEvidence = Join-Path $expectedLogsDirectory "windows-probe-$timestamp.json"
  $processInfo = [System.Diagnostics.ProcessStartInfo]::new()
  $processInfo.FileName = $executable
  $processInfo.UseShellExecute = $false
  $processInfo.RedirectStandardOutput = $true
  $processInfo.RedirectStandardError = $true
  $processInfo.Environment['LIFEOS_STAGE0_HEADLESS'] = $env:LIFEOS_STAGE0_HEADLESS
  $processInfo.Environment['LIFEOS_STAGE0_DATA_DIR'] = $env:LIFEOS_STAGE0_DATA_DIR
  $process = [System.Diagnostics.Process]::new()
  $process.StartInfo = $processInfo
  if (-not $process.Start()) {
    throw "Failed to start Stage 0 executable: $executable"
  }
  $stdoutTask = $process.StandardOutput.ReadToEndAsync()
  $stderrTask = $process.StandardError.ReadToEndAsync()
  $process.WaitForExit()
  $probeExitCode = $process.ExitCode
  $runtimeStdout = $stdoutTask.GetAwaiter().GetResult()
  $runtimeStderr = $stderrTask.GetAwaiter().GetResult()
  [System.IO.File]::WriteAllText(
    $runtimeLog,
    $runtimeStderr + $runtimeStdout,
    [System.Text.UTF8Encoding]::new($false)
  )

  $jsonCandidates = @(
    $runtimeStdout -split "`r?`n" |
      ForEach-Object { $_.Trim() } |
      Where-Object { $_.StartsWith('{') -and $_.EndsWith('}') }
  )
  if ($jsonCandidates.Count -ne 1) {
    throw "Expected exactly one JSON object in $runtimeLog; found $($jsonCandidates.Count)."
  }
  try {
    $probe = $jsonCandidates[0] | ConvertFrom-Json -ErrorAction Stop
  } catch {
    throw "Probe JSON in $runtimeLog is not parseable: $($_.Exception.Message)"
  }
  [System.IO.File]::WriteAllText(
    $jsonEvidence,
    $jsonCandidates[0],
    [System.Text.UTF8Encoding]::new($false)
  )
  if ($probeExitCode -ne 0) {
    throw "Stage 0 Windows headless probe exited with code $probeExitCode."
  }
  if ($probe.status -ne 'PASS') {
    throw "Stage 0 Windows headless probe reported status '$($probe.status)'."
  }
  Write-Output $jsonCandidates[0]
} finally {
  Pop-Location
}
