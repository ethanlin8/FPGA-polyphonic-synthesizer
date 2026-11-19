# Delete old workspace if rebuilding from scratch
file delete -force ./sw/workspace
setws ./sw/workspace

# Automatically find the .xsa file inside ./export/
set xsa_file [lindex [glob ./export/*.xsa] 0]
puts "Building Vitis platform from: $xsa_file"

# Create the Hardware Platform & Standalone MicroBlaze BSP
platform create -name urbana_platform -hw $xsa_file -proc microblaze_0 -os standalone
platform generate

# Create the Application Project
app create -name synth_app -platform urbana_platform -proc microblaze_0 -os standalone -template "Empty Application(C)"

# Link your tracked sw/src/ folder directly into the project
importsources -name synth_app -path [file normalize ./sw/src] -soft-link

# Build the .elf binary
app build -name synth_app