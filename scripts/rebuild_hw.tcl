# If build/ doesn't exist yet, fall back to a full recreate first
if {[llength [glob -nocomplain ./build/*.xpr]] == 0} {
    puts "No existing project found in build/. Running full build_hw.tcl..."
    source ./scripts/build_hw.tcl
} else {
    set xpr_file [lindex [glob ./build/*.xpr] 0]
    open_project $xpr_file

    # Re-run Synthesis (IP caches are preserved for speed)
    reset_run synth_1
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1

    if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
        error "ERROR: Synthesis failed! Check logs in build/."
    }

    # Re-run Implementation & Bitstream Generation
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

    # Export updated .xsa (with bitstream) to ./export/
    file mkdir ./export
    set top_name [get_property top [current_fileset]]
    write_hw_platform -fixed -include_bit -force -file ../export/${top_name}.xsa

    puts "SUCCESS: Bitstream generated and exported to ./export/${top_name}.xsa"
    close_project
}