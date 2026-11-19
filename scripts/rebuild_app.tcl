# If the workspace hasn't been created yet, run the full build_sw.tcl first
if {![file exists "./sw/workspace/synth_app"]} {
    puts "Workspace not found. Running full build_sw.tcl..."
    source ./scripts/build_sw.tcl
} else {
    # Point XSCT to the existing workspace and rebuild only the C application
    setws ./sw/workspace
    puts "Incrementally building synth_app..."
    app build -name synth_app
}

# Flash the bitstream and run the updated .elf on the Urbana Board
source ./scripts/program_board.tcl