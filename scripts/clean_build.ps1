# Get the script's directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Set the project root, which is one level above the scripts directory
$projectRoot = Resolve-Path -Path (Join-Path $scriptDir "..")

# Define the build directory
$buildDir = Join-Path $projectRoot "build"

# Check if the build directory exists and remove it
if (Test-Path $buildDir) {
    Write-Host "Removing build directory: $buildDir"
    Remove-Item -Path $buildDir -Recurse -Force
    Write-Host "Build directory cleaned."
} else {
    Write-Host "Build directory not found. Nothing to clean."
}
