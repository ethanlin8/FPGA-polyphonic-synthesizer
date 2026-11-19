# FPGA Polyphonic Synthesizer (ECE 385 — Urbana Board)
FPGA-Based Polyphonic Synthesizer with a Real-Time HDMI Key Visualizer and MIDI Sequencer

Hardware and embedded MicroBlaze software repository for the Spartan-7 (`xc7s50csga324-1`) Urbana Board using **AMD Vivado & Vitis 2022.2**.

---

## Repository Structure

```text
FPGA-polyphonic-synthesizer/
├── hw/                 # [TRACKED] SystemVerilog/Verilog sources, testbenches, constraints (.xdc)
├── ip_repo/            # [TRACKED] Custom AXI IP repositories (e.g., hdmi_text_controller)
├── export/             # [TRACKED] Exported .xsa hardware handoff from Vivado 2022.2
├── sw/
│   ├── src/            # [TRACKED] MicroBlaze C/C++ application sources (.c, .h)
│   └── workspace/      # [IGNORED] Local Vitis workspace, BSPs, and .elf binaries
├── scripts/
│   ├── recreate.tcl    # [TRACKED] Vivado project & Block Design recreation script (2022.2)
│   └── build_sw.tcl    # [TRACKED] Vitis XSCT workspace recreation script
└── build/              # [IGNORED] Local Vivado .xpr project, synthesis, and bitstream outputs
```

---

## Core Git Rules (Cross-Platform Compatibility)

1. **Never commit `build/` or `sw/workspace/`.** Both folders are generated locally from `scripts/`.
2. **Never commit `.xpr` or `.bd` files.** Opening a project on UIUC EWS (Vivado 2023.1+) upgrades project metadata and breaks compatibility with Vivado 2022.2.
3. **Only export `recreate.tcl`, `.xsa`, and custom IP packages from Vivado 2022.2** (Windows or ECEB lab workstations).
4. **Always edit source code in `hw/`, `ip_repo/`, and `sw/src/`.** Do not edit files inside `build/`.

---

## Hardware Workflow (Vivado 2022.2)

### 1. First-Time Setup / Rebuilding the Vivado Project
Run this whenever cloning the repo for the first time, or after `git pull` when new files or Block Design changes were added:

* **Windows (Vivado 2022.2 Tcl Shell):**
  ```tcl
  cd C:/path/to/FPGA-polyphonic-synthesizer
  file delete -force build
  file mkdir build
  cd build
  source ../scripts/recreate.tcl
  ```
  Then open `build/FPGA-polyphonic-synthesizer.xpr` in the Vivado GUI (or type `start_gui`).

* **UIUC EWS via SSH (Syntax / Synthesis / Simulation Check):**
  ```bash
  cd ~/FPGA-polyphonic-synthesizer
  rm -rf build && mkdir build && cd build
  module load xilinx/2023.1
  vivado -mode batch -source ../scripts/recreate.tcl
  ```
  *(Note: Never commit anything inside `build/`.)*

### 2. Daily Hardware Work
* **Editing existing `.sv`, `.v`, or `.xdc` files:** Edit directly inside `hw/` and save. Vivado links to `hw/` in place—no need to re-run `recreate.tcl`.
* **Adding new files in Vivado 2022.2:**
  1. Place new `.sv`/`.xdc` files inside `hw/` first.
  2. In Vivado, click **Add Sources**, select the files in `../hw/`, and **uncheck "Copy sources into project"**.
* **Saving Block Design or Project Changes (Vivado 2022.2 Only):**
  1. In the Vivado Tcl Console (from inside `build/`), run:
     ```tcl
     write_project_tcl -force ../scripts/recreate.tcl
     ```
  2. If the Block Design or custom IP changed, generate the bitstream and export hardware (**File -> Export -> Export Hardware -> Include bitstream**) into `export/`.
  3. Commit and push `hw/`, `ip_repo/`, `scripts/recreate.tcl`, and `export/*.xsa`.

---

## Software Workflow (Vitis 2022.2)

### 1. Rebuilding the Vitis Workspace
Make sure any open Vitis GUI windows are closed first so `.metadata/.lock` is not held.

* **Windows (`Xilinx Software Command Line Tool 2022.2` / XSCT):**
  ```tcl
  cd C:/path/to/FPGA-polyphonic-synthesizer
  source scripts/build_sw.tcl
  ```
* **Opening the Vitis GUI:**
  Launch **Vitis 2022.2** and set the workspace directory to `<repo_root>/sw/workspace` (or run `exec cmd /c start vitis -workspace ./sw/workspace` from XSCT).

### 2. Daily Software Work
* All `.c` and `.h` files in `sw/src/` are soft-linked into `synth_app/src`. Editing and saving inside Vitis or VS Code updates `sw/src/` directly for Git.
* If new `.c`/`.h` files are added to `sw/src/`, either re-run `xsct scripts/build_sw.tcl` or import them in Vitis with **Advanced -> Create links in workspace** checked.