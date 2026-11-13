# Set workspace to current directory (works even if Vitis GUI is already open on it)
setws ./sw/workspace

# Remove existing projects inside the workspace instead of deleting the locked .metadata folder
catch {app remove synth_app}
catch {platform remove urbana_platform}

# 1. Create the Hardware Platform & Standalone MicroBlaze BSP from the .xsa
platform create -name urbana_platform -hw ./export/design_1_wrapper.xsa -proc microblaze_0 -os standalone
platform generate

# 2. Create the Application Project
app create -name synth_app -platform urbana_platform -proc microblaze_0 -os standalone -template "Empty Application(C)"

# 3. Link your tracked sw/src/ folder directly into the project
importsources -name synth_app -path ./sw/src -soft-link

# 4. Build the .elf binary
app build -name synth_app