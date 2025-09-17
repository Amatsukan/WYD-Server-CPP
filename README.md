# WYD Server - (W2PP)

This repository contains the C++ source code for a server implementation compatible with the game "With Your Destiny" (WYD).

## ⚠️ Disclaimer

This project is based on a decompilation of a previously available server release and is intended for educational and study purposes only. All copyrights and intellectual property rights for the game "With Your Destiny" belong to Hanbitsoft. We do not claim ownership of the original work.

---

## Server Architecture

The server is designed with a distributed architecture, composed of two main services:

*   **`DBSrv` (Database Server):** This service is responsible for all database interactions. It handles the persistence of data such as accounts, characters, items, and rankings.
*   **`TMSrv` (Game Server):** This is the core of the game's backend. It manages active player connections, real-time game logic (movement, combat, skills), and communication with clients. It queries the `DBSrv` to load and save player data.

This separation of concerns allows for better scalability and maintainability.

---

## Compilation

There are two official methods to compile the project. The CMake/MinGW method is recommended for being more modern and independent of a specific IDE.

### Method 1: Visual Studio (Legacy)

1.  Install **Visual Studio** (the project was originally created with VS 2015, but newer versions should work). Make sure to include the **"Desktop development with C++"** workload.
2.  Open the `W2PP Code Project.sln` file in the root of the repository.
3.  Build the solution. This will compile both `DBSrv` and `TMSrv`. The executables will be in their respective project folders inside the build output directory.

### Method 2: CMake / MinGW (Recommended)

This method does not require Visual Studio.

1.  **Install Dependencies:**
    *   [**CMake**](https://cmake.org/download/)
    *   **MinGW-w64** (it's recommended to install it via [MSYS2](https://www.msys2.org/))
2.  **Generate Build Files:**
    Open a terminal, navigate to the root of this repository and run the following commands:
    ```sh
    mkdir build
    cd build
    cmake .. -G "MinGW Makefiles"
    ```

    > **Note:** If you have previously run CMake in this directory with a different generator (like Visual Studio), you may encounter an error. To fix this, clear the build directory by deleting the `CMakeCache.txt` file and the `CMakeFiles` folder before running the `cmake` command again.

3.  **Compile:**
    ```sh
    mingw32-make
    ```
    The executables will be generated inside the `build` directory, in their respective subfolders (`Code/DBSrv` and `Code/TMSrv`).

### Automating with PowerShell Scripts

For convenience, you can use the provided PowerShell scripts to automate the build and clean process. Run these commands from the root of the repository.

*   **To build the project:**
    ```powershell
    .\scripts\build.ps1
    ```
*   **To clean the build directory:**
    ```powershell
    .\scripts\clean_build.ps1
    ```

> **Note:** The `build.ps1` script assumes a default MSYS2 installation path (`C:\msys64\mingw64\bin`). If your installation is in a different location, please edit the script to reflect the correct path for your C and C++ compilers.

---

## Contributing

Pull requests are welcome! To maintain consistency, please try to follow the existing coding patterns and style.

## Contributors

*   **Original Decompilation & Development:**
    *   Klafke
    *   TheHouse
*   **Build System Modernization (CMake/MinGW):**
    *   Amatsukan

## License

This source code is released under the [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).