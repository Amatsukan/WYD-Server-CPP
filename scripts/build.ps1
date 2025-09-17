# Get the script's directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Set the project root, which is one level above the scripts directory
$projectRoot = Resolve-Path -Path (Join-Path $scriptDir "..")

# Define the build directory
$buildDir = Join-Path $projectRoot "build"

# Create the build directory if it doesn't exist
if (-not (Test-Path $buildDir)) {
    Write-Host "Creating build directory: $buildDir"
    New-Item -Path $buildDir -ItemType Directory
}

# Set the location to the build directory
Set-Location $buildDir

# Define CMake arguments
# Note: If your MinGW installation is in a different path, update it here.
$cmakeArgs = @(
    "..",
    "-G `"MinGW Makefiles`"",
    "-D CMAKE_C_COMPILER=`"C:/msys64/mingw64/bin/gcc.exe`"",
    "-D CMAKE_CXX_COMPILER=`"C:/msys64/mingw64/bin/g++.exe`""
)

# Run CMake
Write-Host "Running CMake..."
cmake $cmakeArgs

# Check if CMake was successful
if ($LASTEXITCODE -ne 0) {
    Write-Error "CMake configuration failed."
    exit 1
}

# Run mingw32-make
Write-Host "Running mingw32-make..."
mingw32-make

# Check if make was successful
if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed."
    exit 1
}

Write-Host "Build completed successfully."
