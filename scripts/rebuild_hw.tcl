# Safety check: Ensure we are at the repository root and build/*.xpr exists
set xpr_list [glob -nocomplain ./build/*/*.xpr]
if {[llength $xpr_list] == 0} {
    error "ERROR: No .xpr found in ./build/. Run from the repo root (or run build_hw.tcl first)."
}

# Open the existing project inside build/ (does NOT delete anything)
set xpr_file [lindex $xpr_list 0]
open_project $xpr_file

# Ensure Block Design output products exist (skips instantly if already up-to-date)
set bd_files [get_files -quiet *.bd]
if {[llength $bd_files] > 0} {
    generate_target all $bd_files
    export_ip_user_files -of_objects $bd_files -no_script -sync -force -quiet
}

# Re-run Synthesis & Implementation
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

# Check Setup (WNS) and Hold (WHS) timing slack
set wns [get_property STATS.WNS [get_runs impl_1]]
set whs [get_property STATS.WHS [get_runs impl_1]]
puts "=================================================="
puts "Timing Summary -> WNS (Setup): ${wns} ns | WHS (Hold): ${whs} ns"
puts "=================================================="

if {$wns < 0.0 || $whs < 0.0} {
    puts "WARNING: Timing constraints were NOT met! (WNS=${wns} ns, WHS=${whs} ns)"
}

# Export the local .xsa hardware handoff (including bitstream) to ./export/
file mkdir ./export
set top_name [get_property top [current_fileset]]
write_hw_platform -fixed -include_bit -force -file ./export/${top_name}.xsa
puts "SUCCESS: Exported local hardware handoff to ./export/${top_name}.xsa"

close_project