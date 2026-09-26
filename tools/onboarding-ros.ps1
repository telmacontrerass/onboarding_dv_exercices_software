# Open a ROS 2 Humble shell for onboarding exercises 01-07 Phase A.
# Usage:
#   .\tools\onboarding-ros.ps1
#   .\tools\onboarding-ros.ps1 <command...>
# Example:
#   .\tools\onboarding-ros.ps1 colcon build --symlink-install --packages-select hello_onboarding
[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Command = @()
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$composeFile = Join-Path $root 'docker-compose.onboarding.yml'

Push-Location $root
try {
    $runningServices = & docker compose -f $composeFile ps --status running --services 2>$null
    if ($LASTEXITCODE -ne 0 -or $runningServices -notcontains 'onboarding_ros') {
        Write-Host 'Starting onboarding_ros'
        & docker compose -f $composeFile up -d
        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }
    }

    $dockerArgs = @('compose', '-f', $composeFile, 'exec', 'onboarding_ros', '/entrypoint.sh')
    if ($Command.Count -eq 0) {
        $dockerArgs += 'bash'
    } else {
        $dockerArgs += $Command
    }

    & docker @dockerArgs
    exit $LASTEXITCODE
} finally {
    Pop-Location
}