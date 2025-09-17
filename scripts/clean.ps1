# This script removes the build directory.

# Function to remove the build directory
function Clean-BuildDirectory {
    param($scriptDir)

    $projectRoot = Resolve-Path -Path (Join-Path $scriptDir "..")
    $buildDir = Join-Path $projectRoot "build"

    if (Test-Path $buildDir) {
        Write-Host "Removing build directory: $buildDir"
        Remove-Item -Path $buildDir -Recurse -Force
        Write-Host "Build directory cleaned." -ForegroundColor Green
    } else {
        Write-Host "Build directory not found. Nothing to clean."
    }
}

# --- Main Execution ---
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Clean-BuildDirectory -scriptDir $scriptDir
exit 0