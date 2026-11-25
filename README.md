# FPGA Polyphonic Synthesizer (ECE 385 — Urbana Board)

Hardware and embedded MicroBlaze software repository for the Spartan-7 (`xc7s50csga324-1`) Urbana Board using **AMD Vivado & Vitis 2022.2**.

---

## Current Project State

The current implementation is a hardware polyphonic MIDI synthesizer with a 640x480 HDMI piano renderer.

### Implemented Features

- Eight hardware synthesizer voices running in the `hdmi_text_controller` custom IP.
- Hardware MIDI event FIFO with 64 entries.
- MIDI notes are folded into the 61-key piano range (`MIDI 36..96`) so 88-key controllers and `.mid` files play cleanly.
- Idle/release/active voice allocation and oldest-active voice stealing across all eight voices.
- Pitched sine, sawtooth, and square waveforms with hardware velocity scaling and ADSR envelopes.
- HDMI highlighting derived directly from the eight active hardware voice gates.
- USB boot-keyboard support with six simultaneous HID key slots.
- USB A/Y-style piano controls, octave shifting, waveform controls, two built-in songs, live looper, and UART MIDI input.
- A PC-side Python MIDI bridge for USB MIDI controllers and MIDI files.
- Mono synth audio is duplicated to `audio_l` and `audio_r` on `B13`/`B14`.

### USB Keyboard Controls

| Key | Function |
|---|---|
| `A` through `'` | Piano notes in the selected octave |
| `[` / `]` | Shift the USB piano octave down/up |
| `1` / `2` / `3` | Select sine / sawtooth / square |
| `9` | Toggle the Bach-style built-in arrangement |
| `0` | Toggle the synth progression |
| `-` | Start/stop live MIDI event recording |
| `=` | Toggle loop playback |
| `Backspace` | Panic: silence all voices |

The USB keyboard starts at octave C4 (`MIDI 60`). HID `ErrorRollOver`/`POSTFail` reports are ignored.

### Hardware Register Map

| Offset | Register | Purpose |
|---|---|---|
| `0x00` | `slv_reg0` | Software active-key mask bits `31..0` |
| `0x04` | `slv_reg1` | Software active-key mask bits `63..32` |
| `0x28` | `slv_reg10` | Waveform selection and software override enable |
| `0x2C` | `slv_reg11` | Packed MIDI packet `{status, data1, data2}` |
| `0x30` | `slv_reg12` | ADSR configuration `{release, sustain, decay, attack}` |

The hardware engine combines its own gated voice mask with the software mask for the HDMI piano display.

### Validation Status

- Vivado RTL compilation/elaboration passed.
- The integrated Vivado simulation covers staggered AXI MIDI writes, ADSR behavior, 12-note overlapping voice stealing, and folding/release of MIDI `21` and `108`.
- Out-of-context Vivado 2022.2 post-synthesis setup analysis for the 100 MHz clock reports **WNS = +0.126 ns**.
- This timing result is out-of-context and does not replace a full routed implementation timing report.
- The bridge folds MIDI notes and excludes Channel 10 percussion by default.
- No full board implementation, routed timing run, or Vitis ELF rebuild is claimed in this README until those steps are run with the final checked-in sources.

### MIDI UART Bridge

Install the PC-side dependencies and run `midi_bridge.py`:

```bash
pip install mido pyserial
python scripts/midi_bridge.py --list
python scripts/midi_bridge.py --port COM8
python scripts/midi_bridge.py --port COM8 --midi song.mid
```

The bridge forwards raw MIDI data at `115200` baud. It skips General MIDI Channel 10 percussion unless `--include-drums` is supplied and octave-folds Note On/Note Off messages into `36..96`.

---

## Repository Structure

```text
FPGA-polyphonic-synthesizer/
├── hw/                     # [TRACKED] SystemVerilog/Verilog RTL, testbenches, constraints (.xdc)
├── ip_repo/                # [TRACKED] Custom AXI IP repositories (e.g., hdmi_text_controller)
├── sw/
│   ├── src/                # [TRACKED] MicroBlaze C/C++ application sources (.c, .h)
│   └── workspace/          # [IGNORED] Local Vitis workspace, BSPs, and .elf binaries
├── scripts/
│   ├── recreate.tcl        # [TRACKED] Vivado project & Block Design blueprint (2022.2)
│   ├── build_hw.tcl        # [TRACKED] Full hardware rebuild + timing check + local .xsa export
│   ├── rebuild_hw.tcl      # [TRACKED] Fast incremental RTL build + timing check + local .xsa export
│   ├── build_sw.tcl        # [TRACKED] Full Vitis platform + application workspace build
│   ├── rebuild_app.tcl     # [TRACKED] Fast incremental C build + board programming
│   ├── program_board.tcl   # [TRACKED] JTAG bitstream + MicroBlaze .elf flashing script
│   └── run.tcl             # [TRACKED] Full software rebuild + board programming (build_sw + program_board)
├── export/                 # [IGNORED] Locally generated .xsa hardware handoff (with bitstream)
└── build/                  # [IGNORED] Local Vivado project (build/<project_name>/*.xpr) & outputs
```

---

## Core Git Rules (Cross-Platform Compatibility)

1. **Never commit `build/`, `export/`, or `sw/workspace/`.** All three directories are generated locally via `scripts/`.
2. **Never commit `.xpr`, `.bd`, or `.xsa` files.** Opening a project on UIUC EWS (Vivado 2023.1+) upgrades project metadata and breaks compatibility with Vivado 2022.2.
3. **Only export `recreate.tcl` and custom IP packages (`ip_repo/`) from Vivado 2022.2** (Windows or ECEB lab workstations).
4. **Always edit human-written code inside `hw/`, `ip_repo/`, and `sw/src/`.** Never edit files inside `build/`.
5. **Run all scripts from the repository root (`FPGA-polyphonic-synthesizer/`).**

---

## Hardware Workflow (Vivado 2022.2)

> **First-Time Clone Note:** Because `export/*.xsa` is not tracked in Git, run `build_hw.tcl` once after cloning the repository to generate your local `export/*.xsa` before running any Vitis software scripts.

### 1. Hardware Automation Scripts
* **Full Build from Scratch (`build_hw.tcl`):** Wipes `build/`, recreates the Vivado project inside `build/FPGA-polyphonic-synthesizer/` from `scripts/recreate.tcl`, generates Block Design output products, runs synthesis/implementation, checks setup/hold timing slack (`WNS`/`WHS`), and exports `export/*.xsa` locally.
  ```bash
  vivado -mode batch -source scripts/build_hw.tcl
  ```
* **Fast Incremental RTL Build (`rebuild_hw.tcl`):** Opens the existing `.xpr` inside `build/*/*.xpr`, keeps cached Block Design IPs intact, re-runs synthesis/bitstream generation after RTL edits in `hw/`, checks timing slack, and updates `export/*.xsa` locally.
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
4. Commit and push `hw/`, `ip_repo/`, and `scripts/recreate.tcl`. Your partner pulls the changes and runs `build_hw.tcl` (or `rebuild_hw.tcl`) locally to generate their own `.xsa`.

---

## Software Workflow (Vitis 2022.2 & XSCT)

> **Important:** Close any open Vitis GUI windows before running XSCT scripts so `.metadata/.lock` is not held. Ensure you have run `build_hw.tcl` or `rebuild_hw.tcl` at least once so `export/*.xsa` exists locally.

### 1. Software Automation Scripts
* **Full Build & Flash (`run.tcl`):** Runs `build_sw.tcl` followed immediately by `program_board.tcl`—rebuilding the platform/app from your local `export/*.xsa` and flashing the Urbana Board in one step:
  ```bash
  xsct scripts/run.tcl
  ```
* **Full Platform & App Build Only (`build_sw.tcl`):** Wipes `sw/workspace/`, creates `urbana_platform` and `synth_app` from your local `export/*.xsa`, soft-links `sw/src/`, and compiles `synth_app.elf` without flashing:
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