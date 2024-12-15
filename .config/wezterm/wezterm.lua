-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("FiraCode Nerd Font")
config.color_scheme = "Catppuccin Macchiato"

config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "NONE"

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%D-%M-%Y %H:%M:%S")

	-- Make it italic and underlined
	window:set_right_status(wezterm.format({
		{ Attribute = { Italic = false } },
		{ Text = "Hello " .. date },
	}))
end)

config.keys = {
	-- {
	-- 	key = "h",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	key = "v",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	key = "LeftArrow",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "RightArrow",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.ActivatePaneDirection("Right"),
	-- },
	-- {
	-- 	key = "UpArrow",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "DownArrow",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.ActivatePaneDirection("Down"),
	-- },
	-- {
	-- 	key = "q",
	-- 	mods = "ALT",
	-- 	action = wezterm.action.CloseCurrentPane({ confirm = true }),
	-- },
}

-- config.unix_domains = {
-- 	{
-- 		name = "unix",
-- 	},
-- }

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
-- config.default_gui_startup_args = { "connect", "unix" }

return config
