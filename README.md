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

The recommended method for compiling this project is by using the provided PowerShell scripts, which automate the entire process.

### Method 1: PowerShell Scripts (Recommended)

This is the easiest and most reliable way to build the server.

1.  **Install Dependencies:**
    *   [**CMake**](https://cmake.org/download/)
    *   **MinGW-w64** (it's recommended to install it via [MSYS2](https://www.msys2.org/))

2.  **Ensure MinGW is in your PATH:**
    *   Before running the build scripts, make sure that the `bin` directory of your MinGW-w64 installation (which contains `mingw32-make.exe`, `g++.exe`, etc.) is included in your system's `PATH` environment variable.

3.  **Run the Scripts:**
    Open a PowerShell terminal in the root of the repository and use the following commands:

    *   **To do a full rebuild (recommended):**
        ```powershell
        ./scripts/rebuild.ps1
        ```
    *   **To only build (if you haven't changed CMake files):**
        ```powershell
        ./scripts/build.ps1
        ```
    *   **To only clean the build directory:**
        ```powershell
        ./scripts/clean.ps1
        ```

### Method 2: Manual Compilation

If you prefer to build manually or the scripts do not work for your environment, you can use the traditional methods.

#### Visual Studio (Legacy)

1.  Install **Visual Studio** (the project was originally created with VS 2015, but newer versions should work). Make sure to include the **"Desktop development with C++"** workload.
2.  Open the `W2PP Code Project.sln` file in the root of the repository.
3.  Build the solution.

#### CMake / MinGW

1.  Ensure your MinGW `bin` directory is in your system's PATH.
2.  Open a terminal, navigate to the root of this repository and run the following commands:
    ```sh
    mkdir build
    cd build
    cmake .. -G "MinGW Makefiles"
    mingw32-make
    ```
    > **Note:** If you have previously run CMake in this directory with a different generator (like Visual Studio), you must delete the `build` directory before running the `cmake` command again.

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
