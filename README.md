# FPGA Polyphonic Synthesizer (ECE 385 — Urbana Board)

Hardware and embedded MicroBlaze software repository for the Spartan-7 (`xc7s50csga324-1`) Urbana Board using **AMD Vivado & Vitis 2022.2**.

---

## Repository Structure

```text
FPGA-polyphonic-synthesizer/
├── hw/                     # [TRACKED] SystemVerilog/Verilog RTL, testbenches, constraints (.xdc)
├── ip_repo/                # [TRACKED] Custom AXI IP repositories (e.g., hdmi_text_controller)
├── export/                 # [TRACKED] Exported .xsa hardware handoff from Vivado 2022.2
├── sw/
│   ├── src/                # [TRACKED] MicroBlaze C/C++ application sources (.c, .h)
│   └── workspace/          # [IGNORED] Local Vitis workspace, BSPs, and .elf binaries
├── scripts/
│   ├── recreate.tcl        # [TRACKED] Vivado project & Block Design blueprint (2022.2)
│   ├── build_hw.tcl        # [TRACKED] Full hardware rebuild + timing check + .xsa export
│   ├── rebuild_hw.tcl      # [TRACKED] Fast incremental RTL build + timing check + .xsa export
│   ├── build_sw.tcl        # [TRACKED] Full Vitis platform + application workspace build
│   ├── rebuild_app.tcl     # [TRACKED] Fast incremental C build + board programming
│   ├── program_board.tcl   # [TRACKED] JTAG bitstream + MicroBlaze .elf flashing script
│   └── run.tcl             # [TRACKED] Full software rebuild + board programming (build_sw + program_board)
└── build/                  # [IGNORED] Local Vivado project (build/<project_name>/*.xpr) & outputs
```

---

## Core Git Rules (Cross-Platform Compatibility)

1. **Never commit `build/` or `sw/workspace/`.** Both directories are generated locally via `scripts/`.
2. **Never commit `.xpr` or `.bd` files.** Opening a project on UIUC EWS (Vivado 2023.1+) upgrades project metadata and breaks compatibility with Vivado 2022.2.
3. **Only export `recreate.tcl`, `.xsa`, and custom IP packages from Vivado 2022.2** (Windows or ECEB lab workstations). Both `build_hw.tcl` and `rebuild_hw.tcl` include a `2022.2` version guard so running them on EWS automatically skips overwriting `export/*.xsa`.
4. **Always edit human-written code inside `hw/`, `ip_repo/`, and `sw/src/`.** Never edit files inside `build/`.
5. **Run all scripts from the repository root (`FPGA-polyphonic-synthesizer/`).**

---

## Hardware Workflow (Vivado 2022.2)

### 1. Hardware Automation Scripts
* **Full Build from Scratch (`build_hw.tcl`):** Wipes `build/`, recreates the Vivado project inside `build/FPGA-polyphonic-synthesizer/` from `scripts/recreate.tcl`, generates Block Design output products, runs synthesis/implementation, checks setup/hold timing slack (`WNS`/`WHS`), and exports `export/*.xsa` (on `2022.2` only).
  ```bash
  vivado -mode batch -source scripts/build_hw.tcl
  ```
* **Fast Incremental RTL Build (`rebuild_hw.tcl`):** Opens the existing `.xpr` inside `build/*/*.xpr`, keeps cached Block Design IPs intact, re-runs synthesis/bitstream generation after RTL edits in `hw/`, checks timing slack, and exports `export/*.xsa` (on `2022.2` only).
  ```bash
  vivado -mode batch -source scripts/rebuild_hw.tcl
  ```

### 2. Opening the Project in the Vivado GUI
* **If `build/` already exists:** Double-click `build/FPGA-polyphonic-synthesizer/FPGA-polyphonic-synthesizer.xpr`.
* **If `build/` does not exist yet (Windows Vivado 2022.2 Tcl Shell):**
  ```tcl
  cd C:/path/to/FPGA-polyphonic-synthesizer
  file mkdir build
  cd build
  source ../scripts/recreate.tcl
  start_gui
  ```
* **Testing Synthesis/Implementation on UIUC EWS (SSH):**
  ```bash
  cd ~/FPGA-polyphonic-synthesizer
  module load xilinx/2023.1
  vivado -mode batch -source scripts/build_hw.tcl
  ```
  *(Note: Never run `write_project_tcl` from EWS 2023.1+.)*

### 3. Saving Block Design or Project Changes (Vivado 2022.2 Only)
Whenever you add/remove files in `hw/`, modify the Block Design, or repackage a custom IP in `ip_repo/`:
1. When adding new files in Vivado, ensure they live in `hw/` first and **uncheck "Copy sources into project"**.
2. Keep **Incremental Synthesis disabled** in Vivado Settings so `recreate.tcl` never references local `.dcp` checkpoints.
3. In the Vivado Tcl Console (navigate to `build/` via `cd ..` if currently inside `build/FPGA-polyphonic-synthesizer`), run:
   ```tcl
   write_project_tcl -force ../scripts/recreate.tcl
   ```
4. Export the updated hardware handoff (**File -> Export -> Export Hardware -> Include bitstream**) into `export/`, or run `vivado -mode batch -source scripts/rebuild_hw.tcl`.
5. Commit and push `hw/`, `ip_repo/`, `scripts/recreate.tcl`, and `export/*.xsa`.

---

## Software Workflow (Vitis 2022.2 & XSCT)

> **Important:** Close any open Vitis GUI windows before running XSCT scripts so `.metadata/.lock` is not held.

### 1. Software Automation Scripts
* **Full Build & Flash (`run.tcl`):** Runs `build_sw.tcl` followed immediately by `program_board.tcl`—rebuilding the platform/app from `export/*.xsa` and flashing the Urbana Board in one step:
  ```bash
  xsct scripts/run.tcl
  ```
* **Full Platform & App Build Only (`build_sw.tcl`):** Wipes `sw/workspace/`, creates `urbana_platform` and `synth_app` from `export/*.xsa`, soft-links `sw/src/`, and compiles `synth_app.elf` without flashing:
  ```bash
  xsct scripts/build_sw.tcl
  ```
* **Fast Incremental Edit & Flash (`rebuild_app.tcl`):** Recompiles `synth_app.elf` (~3 seconds) after editing existing `.c`/`.h` files in `sw/src/` and immediately flashes the Urbana Board:
  ```bash
  xsct scripts/rebuild_app.tcl
  ```
* **Flash Board Only (`program_board.tcl`):** Programs the Spartan-7 (`xc7s50`) with the `.bit` file and downloads/runs `synth_app.elf` on `MicroBlaze #0`:
  ```bash
  xsct scripts/program_board.tcl
  ```

### 2. Using the Vitis GUI
* Launch **Vitis 2022.2** and set the workspace to `<repo_root>/sw/workspace` (or run `exec cmd /c start vitis -workspace ./sw/workspace` followed by `exit` in XSCT).
* Files inside `sw/src/` are soft-linked into `synth_app/src`—edits saved in Vitis or VS Code modify `sw/src/` directly for Git.

### 3. Troubleshooting Notes
* **Custom IP `Makefile` Bug on Windows:** If a newly packaged IP driver fails to compile with `cc1.exe: fatal error: *.c: Invalid argument`, update `ip_repo/<ip_name>/drivers/<ip_name>/src/Makefile` to use `LIBSOURCES=$(wildcard *.c)` and `OBJECTS = $(addsuffix .o, $(basename $(wildcard *.c)))`, then repackage the IP in Vivado 2022.2.