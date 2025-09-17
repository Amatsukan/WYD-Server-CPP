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
    cmake .. -G "MinGW Makefiles"
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configuration failed."
    }
}

# Function to run the compiler (make)
function Invoke-Make {
    Write-Host "Running mingw32-make..."
    mingw32-make
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
    Invoke-Make

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
