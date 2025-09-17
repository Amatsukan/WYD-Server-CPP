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

The recommended method for compiling this project is by using the provided PowerShell scripts, which automate the entire process using CMake and MSVC (the Microsoft Visual C++ compiler).

### Prerequisites

Before you begin, ensure you have the following installed:

*   [**Visual Studio 2022**](https://visualstudio.microsoft.com/downloads/): Make sure to include the **"Desktop development with C++"** workload during installation.
*   [**CMake**](https://cmake.org/download/): Ensure it is added to your system's PATH.

---

### Method 1: PowerShell Scripts (Recommended)

This is the easiest and most reliable way to build the server. The scripts will use CMake to generate a Visual Studio solution inside the `build` directory and then compile it.

Open a PowerShell terminal in the root of the repository and use the following commands:

*   **To do a full rebuild (cleans, generates, and builds):**
    ```powershell
    ./scripts/rebuild.ps1
    ```
*   **To build (if you haven't changed CMake files):**
    ```powershell
    ./scripts/build.ps1
    ```
*   **To clean the build directory:**
    ```powershell
    ./scripts/clean.ps1
    ```

---

### Method 2: Manual Compilation with CMake

If you prefer to build manually, you can use CMake directly to generate the project files and then compile them.

1.  Open a terminal (like the Developer Command Prompt for VS 2022 or PowerShell).
2.  Navigate to the root of this repository.
3.  Run the following commands:

    ```sh
    # Create a build directory
    mkdir build
    cd build

    # Generate the Visual Studio solution
    cmake .. -G "Visual Studio 17 2022" -A x64

    # Build the project
    cmake --build . --config Release
    ```

4.  Alternatively, after running the first `cmake` command, you can open the generated `WYD-Server.sln` file inside the `build` directory with Visual Studio and build the solution from there.

---

## Contributing

Pull requests are welcome! To maintain consistency, please try to follow the existing coding patterns and style.

## Contributors

*   **Original Decompilation & Development:**
    *   Klafke
    *   TheHouse
*   **Build System Modernization (CMake/MSVC):**
    *   Amatsukan

## License

This source code is released under the [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
