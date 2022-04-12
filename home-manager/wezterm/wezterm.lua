local wezterm = require("wezterm")
local modCtrl = "CTRL"
local modLeader = "LEADER"
local modShift = "SHIFT"
local modLeaderShift = modLeader .. "|" .. modShift
local modCtrlShift = modCtrl .. "|" .. modShift

return {
	default_prog = { "fish", "-l" },

	font = wezterm.font("Cica"),
	font_size = 14,

	color_scheme = "nord",

	audible_bell = "Disabled",

	exit_behavior = "Close",

	show_update_window = false,

	disable_default_key_bindings = true,
	leader = { key = "q", mods = modCtrl },
	keys = {
		-- Split pane
		{
			key = "-",
			mods = modLeader,
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "|",
			mods = modLeaderShift,
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "\\",
			mods = modLeader,
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		-- Move pane
		{ key = "h", mods = modLeader, action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = modLeader, action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = modLeader, action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = modLeader, action = wezterm.action({ ActivatePaneDirection = "Right" }) },

		-- Resize pane
		{ key = "H", mods = modLeaderShift, action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = modLeaderShift, action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = modLeaderShift, action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = modLeaderShift, action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },

		-- Move tab
		{ key = "n", mods = modLeader, action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "p", mods = modLeader, action = wezterm.action({ ActivateTabRelative = -1 }) },

		-- Change font size
		{ key = "=", mods = modCtrl, action = "IncreaseFontSize" },
		{ key = "-", mods = modCtrl, action = "DecreaseFontSize" },

		-- Reload
		{ key = "R", mods = modCtrlShift, action = "ReloadConfiguration" },
	},
}
