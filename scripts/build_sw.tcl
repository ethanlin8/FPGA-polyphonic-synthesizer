# Delete old workspace if rebuilding from scratch
file delete -force ./sw/workspace
setws ./sw/workspace

# 1. Create the Hardware Platform & Standalone MicroBlaze BSP from the .xsa
platform create -name urbana_platform -hw ./export/design_1_wrapper.xsa -proc microblaze_0 -os standalone
platform generate

# 2. Create the Application Project
app create -name synth_app -platform urbana_platform -proc microblaze_0 -os standalone -template "Empty Application(C)"

# 3. Link your tracked sw/src/ folder directly into the project
importsources -name synth_app -path ./sw/src -soft-link

# 4. Build the .elf binary
app build -name synth_app

# 5. Launch Vitis GUI directly into the workspace
exec vitis -workspace ./sw/workspace &