# This script configures and builds the project.

# Function to source config and set up the environment
function Initialize-Environment {
    param($scriptDir)

    $configPath = Join-Path $scriptDir "config.ps1"
    if (-not (Test-Path $configPath)) {
        throw "Configuration file not found: $configPath. Please ensure it exists in the scripts directory."
    }
    . $configPath # Source the config file
}

# Function to prepare the build directory
function Enter-BuildDirectory {
    param($scriptDir)

    $projectRoot = Resolve-Path -Path (Join-Path $scriptDir "..")
    $buildDir = Join-Path $projectRoot "build"

    if (-not (Test-Path $buildDir)) {
        Write-Host "Creating build directory: $buildDir"
        New-Item -Path $buildDir -ItemType Directory
    }

    Set-Location $buildDir
}

# Function to run CMake
function Invoke-CMake {
    Write-Host "Running CMake..."
    cmake .. -G "Visual Studio 17 2022" -A x64
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configuration failed."
    }
}

# Function to run the compiler (msbuild)
function Invoke-Build {
    Write-Host "Running msbuild..."
    cmake --build . --config Release
    if ($LASTEXITCODE -ne 0) {
        throw "Build failed."
    }
}

# --- Main Execution ---
$startDir = Get-Location

try {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    
    Initialize-Environment -scriptDir $scriptDir
    Enter-BuildDirectory -scriptDir $scriptDir
    Invoke-CMake
    Invoke-Build

    Write-Host "Build completed successfully." -ForegroundColor Green
}
catch {
    Write-Error $_.Exception.Message
    # Exit with a non-zero code to indicate failure, which can be caught by other scripts.
    exit 1
}
finally {
    Write-Host "Returning to original directory: $startDir"
    Set-Location $startDir
}