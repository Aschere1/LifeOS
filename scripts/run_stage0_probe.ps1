[CmdletBinding()]
param(
  [switch]$SkipAndroid,
  [ValidateRange(1, 300)]
  [int]$ProbeTimeoutSeconds = 30
)

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
$javaHome = 'D:\Archer\LifeOS-stage0-tools\jdk\jdk-21.0.12.1+1'
$androidSdk = 'D:\Archer\LifeOS-stage0-tools\android-sdk'
$pubCache = 'D:\Archer\LifeOS-stage0-tools\pub-cache'
$gradleUserHome = 'D:\Archer\LifeOS-stage0-tools\gradle-cache'

foreach ($requiredPath in @($flutter, $javaHome, $androidSdk, $gradleUserHome)) {
  if (-not (Test-Path -LiteralPath $requiredPath)) {
    throw "Pinned Stage 0 tool path not found: $requiredPath"
  }
}
if (-not (Test-Path -LiteralPath $pubCache)) {
  New-Item -ItemType Directory -Force -Path $pubCache | Out-Null
}

$expectedFlutterVersion = @{
  frameworkVersion = '3.47.2'
  flutterVersion = '3.47.2'
  dartSdkVersion = '3.13.2'
  channel = 'stable'
  repositoryUrl = 'https://github.com/flutter/flutter.git'
  frameworkRevision = 'd3b14c876900e553bc736ca19295fc09e3853e8e'
  engineRevision = 'a804b261645ef8c13eb3d5c44a5c2fb0340c5539'
}
try {
  $flutterMachineVersion = (& $flutter --version --machine) -join "`n"
  if ($LASTEXITCODE -ne 0) {
    throw "flutter --version --machine exited with code $LASTEXITCODE"
  }
  $flutterInfo = $flutterMachineVersion | ConvertFrom-Json -ErrorAction Stop
} catch {
  throw "Pinned Flutter machine-version check failed: $($_.Exception.Message)"
}
foreach ($property in $expectedFlutterVersion.Keys) {
  if ($flutterInfo.$property -cne $expectedFlutterVersion[$property]) {
    throw "Pinned Flutter machine-version mismatch for ${property}: expected '$($expectedFlutterVersion[$property])', got '$($flutterInfo.$property)'."
  }
}

$env:JAVA_HOME = $javaHome
$env:ANDROID_HOME = $androidSdk
$env:ANDROID_SDK_ROOT = $androidSdk
$env:PUB_CACHE = $pubCache
$env:GRADLE_USER_HOME = $gradleUserHome
$env:PATH = "$javaHome\bin;$androidSdk\platform-tools;$env:PATH"
if ($env:JAVA_HOME -ne $javaHome -or
    $env:ANDROID_HOME -ne $androidSdk -or
    $env:ANDROID_SDK_ROOT -ne $androidSdk -or
    $env:PUB_CACHE -ne $pubCache -or
    $env:GRADLE_USER_HOME -ne $gradleUserHome) {
  throw 'Unable to set the pinned D: Stage 0 environment paths.'
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
  $runtimeStdout = ''
  $runtimeStderr = ''
  $probeExitCode = $null
  $timedOut = $false
  $processError = $null
  $started = $false
  $stdoutTask = $null
  $stderrTask = $null
  try {
    if (-not $process.Start()) {
      throw "Failed to start Stage 0 executable: $executable"
    }
    $started = $true
    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    if (-not $process.WaitForExit($ProbeTimeoutSeconds * 1000)) {
      $timedOut = $true
      $process.Kill($true)
      if (-not $process.WaitForExit(5000)) {
        $processError = 'Owned probe process did not exit within 5 seconds after timeout termination'
      }
    }
    if ($process.HasExited) {
      $probeExitCode = $process.ExitCode
    }
  } catch {
    $processError = $_.Exception.Message
  } finally {
    try {
      if ($started -and -not $process.HasExited) {
        try {
          $process.Kill($true)
          if (-not $process.WaitForExit(5000)) {
            $cleanupError = 'Owned probe process did not exit within 5 seconds during cleanup'
            $processError = if ($processError) { "$processError; $cleanupError" } else { $cleanupError }
          }
        } catch {
          $cleanupError = "Owned probe process cleanup failed: $($_.Exception.Message)"
          $processError = if ($processError) { "$processError; $cleanupError" } else { $cleanupError }
        }
      }
      if ($started -and $process.HasExited) {
        $probeExitCode = $process.ExitCode
      }
      if ($null -ne $stdoutTask) {
        try {
          if ($stdoutTask.Wait(5000)) {
            $runtimeStdout = $stdoutTask.GetAwaiter().GetResult()
          } else {
            $processError = if ($processError) { "$processError; stdout drain timed out" } else { 'stdout drain timed out' }
          }
        } catch {
          $drainError = "stdout drain failed: $($_.Exception.Message)"
          $processError = if ($processError) { "$processError; $drainError" } else { $drainError }
        }
      }
      if ($null -ne $stderrTask) {
        try {
          if ($stderrTask.Wait(5000)) {
            $runtimeStderr = $stderrTask.GetAwaiter().GetResult()
          } else {
            $processError = if ($processError) { "$processError; stderr drain timed out" } else { 'stderr drain timed out' }
          }
        } catch {
          $drainError = "stderr drain failed: $($_.Exception.Message)"
          $processError = if ($processError) { "$processError; $drainError" } else { $drainError }
        }
      }
    } finally {
      $process.Dispose()
    }
  }
  if ($timedOut) {
    $runtimeStderr += "`nSCRIPT_TIMEOUT: probe exceeded $ProbeTimeoutSeconds seconds; the owned process tree was terminated.`n"
  }
  if ($processError) {
    $runtimeStderr += "`nSCRIPT_PROCESS_ERROR: $processError`n"
  }
  [System.IO.File]::WriteAllText(
    $runtimeLog,
    $runtimeStderr + $runtimeStdout,
    [System.Text.UTF8Encoding]::new($false)
  )
  if ($processError) {
    throw "Stage 0 Windows headless probe process error: $processError"
  }
  if ($timedOut) {
    throw "Stage 0 Windows headless probe exceeded $ProbeTimeoutSeconds seconds."
  }

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

  if (-not $SkipAndroid) {
    & $flutter build apk --debug
    if ($LASTEXITCODE -ne 0) { throw 'flutter build apk --debug failed.' }
  }
} finally {
  Pop-Location
}
