-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Color scheme:
config.color_scheme = "Dracula (Official)"
-- Fonts:
config.font = wezterm.font_with_fallback({
	-- "3270 Nerd Font",
	"IosevkaTerm NF",
})
-- Default shell:
config.default_prog = {
	"pwsh.exe",
	"-NoExit",
	"-Command",
	'&{Import-Module "C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell 0af32636 -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64" }',
}
-- Default current working directory
config.default_cwd = wezterm.home_dir .. "/source/repos"
-- and finally, return the configuration to wezterm
return config
