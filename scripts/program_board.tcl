# Connect to the local hardware server (USB-JTAG to Urbana Board)
connect

# Automatically find the extracted .bit file inside the platform directory
set bit_file [lindex [glob ./sw/workspace/urbana_platform/hw/*.bit] 0]
puts "Programming FPGA with: $bit_file"

# Select the Spartan-7 FPGA target and flash the bitstream
targets -set -filter {name =~ "*xc7s50*"}
fpga -file $bit_file

# Select the MicroBlaze processor, reset it, download the .elf, and run
targets -set -filter {name =~ "*MicroBlaze #0*"}
rst -processor
dow ./sw/workspace/synth_app/Debug/synth_app.elf
con

# Disconnect XSCT so the JTAG port isn't left locked
disconnect