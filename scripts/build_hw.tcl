# 1. Wipe any old build directory and recreate the Vivado project inside build/
file delete -force ./build
file mkdir ./build
cd ./build

source ../scripts/recreate.tcl

# 2. Refresh custom IP repo and upgrade any locked/out-of-date IPs (useful for EWS 2023.1+ or repackaged IPs)
update_ip_catalog -rebuild -quiet
set locked_ips [get_ips -quiet -filter {IS_LOCKED == 1}]
if {[llength $locked_ips] > 0} {
    puts "Upgrading locked/out-of-date IPs: $locked_ips"
    upgrade_ip -quiet $locked_ips
}

# 3. Ensure Block Design output products & IP checkpoints exist
set bd_files [get_files -quiet *.bd]
if {[llength $bd_files] > 0} {
    puts "Generating Block Design output products..."
    generate_target all $bd_files
    export_ip_user_files -of_objects $bd_files -no_script -sync -force -quiet
}

# 4. Run Synthesis
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "ERROR: Synthesis failed! Check logs in build/."
}

# 5. Run Implementation and Bitstream Generation
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "ERROR: Implementation or Bitstream generation failed!"
}

# 6. Check Setup (WNS) and Hold (WHS) timing slack
set wns [get_property STATS.WNS [get_runs impl_1]]
set whs [get_property STATS.WHS [get_runs impl_1]]
puts "=================================================="
puts "Timing Summary -> WNS (Setup): ${wns} ns | WHS (Hold): ${whs} ns"
puts "=================================================="

if {$wns < 0.0 || $whs < 0.0} {
    puts "WARNING: Timing constraints were NOT met! (WNS=${wns} ns, WHS=${whs} ns)"
}

# 7. Export local .xsa hardware handoff (including bitstream) to ../export/
file mkdir ../export
set top_name [get_property top [current_fileset]]
write_hw_platform -fixed -include_bit -force -file ../export/${top_name}.xsa

puts "SUCCESS: Bitstream generated and exported to ../export/${top_name}.xsa"