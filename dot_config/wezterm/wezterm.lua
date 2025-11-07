local wezterm = require("wezterm")

local modCtrl = "CTRL"
local modLeader = "LEADER"
local modShift = "SHIFT"
local modLeaderShift = modLeader .. "|" .. modShift
local modCtrlShift = modCtrl .. "|" .. modShift
local modNone = "NONE"

wezterm.on("update-right-status", function(window, _)
	local leader = ""
	if window:leader_is_active() then
		leader = wezterm.format({
			{ Foreground = { Color = "#434C5E" } },
			{ Background = { Color = "#8FBCBB" } },
			{ Text = "  LEADER" },
		})
	end
	window:set_right_status(leader)
end)

return {
	default_prog = { "/opt/homebrew/bin/fish", "-l" },

	font = wezterm.font_with_fallback({
		"UDEV Gothic 35NFLG",
	}),
	font_size = 14,

	use_fancy_tab_bar = false,

	initial_cols = 64,
	initial_rows = 24,

	-- window_background_opacity = 0.8,
	color_scheme = "Rosé Pine Moon (base16)",

	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.7,
	},

	audible_bell = "Disabled",

	exit_behavior = "Close",

	disable_default_key_bindings = true,
	leader = { key = ",", mods = modCtrl },
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

		-- Add tab
		{ key = "t", mods = modLeader, action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },

		-- Move tab
		{ key = "n", mods = modLeader, action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "p", mods = modLeader, action = wezterm.action({ ActivateTabRelative = -1 }) },

		-- Change font size
		{ key = "=", mods = modCtrl, action = "IncreaseFontSize" },
		{ key = "-", mods = modCtrl, action = "DecreaseFontSize" },

		-- Reload
		{ key = "R", mods = modCtrlShift, action = "ReloadConfiguration" },

		-- Clipboard
		{ key = "c", mods = modLeader, action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = modLeader, action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "x", mods = modLeader, action = "ActivateCopyMode" },
		{ key = "x", mods = modLeaderShift, action = "QuickSelect" },
	},

	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = modNone,
			action = wezterm.action({ CompleteSelection = "Clipboard" }),
		},
	},
}
