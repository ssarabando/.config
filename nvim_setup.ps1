if (Test-Path "$home/AppData/Local/nvim/") {
    "Neovim configuration directory already exists. Aborting."
    exit 1
}
if (Test-Path "$home/AppData/Local/nvim-data/") {
    # Nuke existing data directory
    rm "$home/AppData/Local/nvim-data/" -Recurse -Force
}
New-Item -ItemType SymbolicLink -Path "$home/AppData/Local/nvim/" -Target "$home/.config/nvim/"
