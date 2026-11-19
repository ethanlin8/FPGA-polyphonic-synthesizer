connect

# 1. Flash the Spartan-7 bitstream
set bit_file [lindex [glob ./sw/workspace/urbana_platform/hw/*.bit] 0]
puts "Programming FPGA with: $bit_file"
targets -set -filter {name =~ "*xc7s50*"}
fpga -file $bit_file

# Wait 500ms for Clocking Wizard (MMCM/PLL) and Processor System Reset to stabilize
after 500

# 2. Select MicroBlaze (case-insensitive match handles "MicroBlaze #0" or "microblaze_0")
targets -set -nocase -filter {name =~ "*microblaze*"}

# Halt and reset the processor cleanly before downloading
catch {stop}
rst -processor
after 100

# 3. Download the .elf into Block RAM and resume execution
set elf_file "./sw/workspace/synth_app/Debug/synth_app.elf"
puts "Downloading ELF: $elf_file"
dow $elf_file
con

# Give JTAG a moment to flush before disconnecting
after 200
disconnect