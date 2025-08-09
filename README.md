# 2048 in RISC-V Assembly

A simple 2048 game engine written in RISC-V assembly, with:
- A Java GUI to play the game
- An automated test harness using the Venus RISC-V simulator

This repository includes all sources, a GUI JAR, and a Venus JAR for local development and testing.

## Requirements
- Java 11+ (for `gui.jar` and `venus-61c.dev.jar`)
- Python 3.8+ (for helper scripts)
- Windows, macOS, or Linux

## Project Structure
- `src/`
  - `main.s` — program entrypoint and game loop
  - `buffer.s` — board buffer utilities
  - `check_victory.s` — win/lose detection
  - `complete_move.s` — executes a full move (shift + merges + placement)
  - `merge.s` — merge logic for adjacent tiles
  - `move_check.s` — checks if a move is possible
  - `move_left.s` — left move primitive used by other directions
  - `move_one.s` — slides a single tile
  - `place.s` — places a new random tile
  - `points.s` — calculates points for a move
  - `printboard.s` — text rendering of the board
  - `util.s` — shared helpers
- `tests/`
  - `pub/` — public unit tests (`.s`) with expected outputs (`.ref`)
  - `test_utils.s` — test utilities used by the public tests
- `run_gui.py` — launches the GUI and runs the RISC-V program
- `run_tests.py` — runs unit tests on Venus
- `gui.jar` — the game GUI client
- `venus-61c.dev.jar` — Venus RISC-V simulator

## Running the tests
From the project root, in PowerShell:

- Run all tests (default public tests):
  
  ```powershell
  python .\run_tests.py
  ```

- List available tests:
  
  ```powershell
  python .\run_tests.py -l
  ```

- Run a specific test (example):
  
  ```powershell
  python .\run_tests.py -t test_move_left_1 -d pub
  ```

The script compares program output to the corresponding `.ref` file and reports PASS/FAIL.

## Running the GUI (play the game)
In PowerShell:

```powershell
python .\run_gui.py
```

Controls in the GUI map to the game as follows:
- Up/Down/Left/Right → W/S/A/D (sent to the RISC-V program)

The GUI connects to the game via a local socket (localhost:55555), and the script starts the simulator for you.

## Running the program manually (CLI)
You can also run the entrypoint directly on Venus:

```powershell
java -jar .\venus-61c.dev.jar src\main.s
```

The program prints board states to stdout and reads moves (`w`, `a`, `s`, `d`) from stdin.

## Troubleshooting
- "java" is not recognized: install a JRE/JDK and ensure Java is on your PATH.
- Port 55555 is busy: close other programs using the port or change the port in `run_gui.py`.
- If the GUI script fails to start the simulator on your OS, run the program manually with Venus (see above), or adapt the call in `run_gui.py` to use the included JAR.

## Notes
- This is a learning project showcasing low-level implementation of 2048 mechanics (movement, merging, scoring, win detection) in RISC-V assembly.
- Venus is used purely as a simulator; no external Python packages are required.

## License
Add a license of your choice (e.g., MIT) before publishing.
