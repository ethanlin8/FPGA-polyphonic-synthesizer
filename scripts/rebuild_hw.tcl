# 1. Safety check: Find the .xpr inside ./build/<project_name>/*.xpr
set xpr_list [glob -nocomplain ./build/*/*.xpr]
if {[llength $xpr_list] == 0} {
    error "ERROR: No .xpr found in ./build/*/. Run from the repo root (or run build_hw.tcl first)."
}

# Open the existing project inside build/ (does NOT delete anything)
set xpr_file [lindex $xpr_list 0]
open_project $xpr_file

# 2. Refresh custom IP repo and upgrade any locked/out-of-date IPs
update_ip_catalog -rebuild -quiet
set locked_ips [get_ips -quiet -filter {IS_LOCKED == 1}]
if {[llength $locked_ips] > 0} {
    puts "Upgrading locked/out-of-date IPs: $locked_ips"
    upgrade_ip -quiet $locked_ips
}

# 3. Ensure Block Design output products exist (skips instantly if already up-to-date)
set bd_files [get_files -quiet *.bd]
if {[llength $bd_files] > 0} {
    generate_target all $bd_files
    export_ip_user_files -of_objects $bd_files -no_script -sync -force -quiet
}

# 4. Re-run Synthesis & Implementation
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "ERROR: Synthesis failed! Check logs in build/."
}

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "ERROR: Implementation or Bitstream generation failed!"
}

# 5. Check Setup (WNS) and Hold (WHS) timing slack
set wns [get_property STATS.WNS [get_runs impl_1]]
set whs [get_property STATS.WHS [get_runs impl_1]]
puts "=================================================="
puts "Timing Summary -> WNS (Setup): ${wns} ns | WHS (Hold): ${whs} ns"
puts "=================================================="

if {$wns < 0.0 || $whs < 0.0} {
    puts "WARNING: Timing constraints were NOT met! (WNS=${wns} ns, WHS=${whs} ns)"
}

# 6. Export updated local .xsa hardware handoff (including bitstream) to ./export/
file mkdir ./export
set top_name [get_property top [current_fileset]]
write_hw_platform -fixed -include_bit -force -file ./export/${top_name}.xsa

puts "SUCCESS: Bitstream generated and exported to ./export/${top_name}.xsa"