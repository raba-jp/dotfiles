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
		leader = "LEADER"
	end
	window:set_right_status(leader)
end)

wezterm.on("window-config-reloaded", function(window, _)
	window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000)
end)

return {
	default_prog = { "fish", "-l" },

	--font = wezterm.font("Cica"),
	font = wezterm.font_with_fallback({
		"UDEV Gothic 35NFLG",
	}),
	font_size = 14,

	use_fancy_tab_bar = false,

	color_scheme = "nord",
	colors = {
		tab_bar = {
			background = "#2e3440",
			active_tab = {
				bg_color = "#4c566a",
				fg_color = "#d8dee9",
			},
			inactive_tab = {
				bg_color = "#3b4252",
				fg_color = "#d8dee9",
			},
			new_tab = {
				bg_color = "#4c566a",
				fg_color = "#d8dee9",
			},
		},
	},
	inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.7,
	},

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
