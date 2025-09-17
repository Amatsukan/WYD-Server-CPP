# This script rebuilds the project by first cleaning and then building.

# Function to invoke another script and check for errors
function Invoke-Script {
    param(
        [string]$scriptPath
    )

    & $scriptPath

    if ($LASTEXITCODE -ne 0) {
        throw "Script failed: $scriptPath"
    }
}

# --- Main Execution ---
$startDir = Get-Location

try {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    
    $cleanScript = Join-Path $scriptDir "clean.ps1"
    $buildScript = Join-Path $scriptDir "build.ps1"

    Write-Host "--- Running Clean Script ---" -ForegroundColor Yellow
    Invoke-Script -scriptPath $cleanScript
    
    Write-Host ""
    Write-Host "--- Running Build Script ---" -ForegroundColor Yellow
    Invoke-Script -scriptPath $buildScript

    Write-Host ""
    Write-Host "Rebuild completed successfully." -ForegroundColor Green
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
finally {
    # The other scripts will return to the start directory, but we do it here
    # as well just in case the rebuild script itself is ever modified to change location.
    Set-Location $startDir
}