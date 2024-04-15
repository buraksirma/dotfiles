local wezterm = require("wezterm")
local act = wezterm.action

local shortcuts = {}

local map = function(key, mods, action)
	if type(mods) == "string" then
		table.insert(shortcuts, { key = key, mods = mods, action = action })
	elseif type(mods) == "table" then
		for _, mod in pairs(mods) do
			table.insert(shortcuts, { key = key, mods = mod, action = action })
		end
	end
end

local toggleTabBar = wezterm.action_callback(function(window)
	wezterm.GLOBAL.enable_tab_bar = not wezterm.GLOBAL.enable_tab_bar
	window:set_config_overrides({
		enable_tab_bar = wezterm.GLOBAL.enable_tab_bar,
	})
end)

local openUrl = act.QuickSelectArgs({
	label = "open url",
	patterns = { "https?://\\S+" },
	action = wezterm.action_callback(function(window, pane)
		local url = window:get_selection_text_for_pane(pane)
		wezterm.open_with(url)
	end),
})

-- use 'Backslash' to split horizontally
map("v", "LEADER", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
-- and 'Minus' to split vertically
map("s", "LEADER", act.SplitVertical({ domain = "CurrentPaneDomain" }))
-- map 1-9 to switch to tab 1-9, 0 for the last tab
for i = 1, 9 do
	map(tostring(i), { "LEADER", "SUPER" }, act.ActivateTab(i - 1))
end
map("0", { "LEADER", "SUPER" }, act.ActivateTab(-1))
-- 'hjkl' to move between panes
map("h", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Left"))
map("j", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Down"))
map("k", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Up"))
map("l", { "LEADER", "SUPER" }, act.ActivatePaneDirection("Right"))
-- resize
map("h", "LEADER|SHIFT", act.AdjustPaneSize({ "Left", 5 }))
map("j", "LEADER|SHIFT", act.AdjustPaneSize({ "Down", 5 }))
map("k", "LEADER|SHIFT", act.AdjustPaneSize({ "Up", 5 }))
map("l", "LEADER|SHIFT", act.AdjustPaneSize({ "Right", 5 }))
-- spawn & close
map("c", "LEADER", act.SpawnTab("CurrentPaneDomain"))
map("x", "LEADER", act.CloseCurrentPane({ confirm = true }))
map("t", { "SHIFT|CTRL", "SUPER" }, act.SpawnTab("CurrentPaneDomain"))
map("w", { "SHIFT|CTRL", "SUPER" }, act.CloseCurrentTab({ confirm = true }))
map("n", { "SHIFT|CTRL", "SUPER" }, act.SpawnWindow)
-- zoom states
map("z", { "LEADER", "SUPER" }, act.TogglePaneZoomState)
map("Z", { "LEADER", "SUPER" }, toggleTabBar)
-- copy & paste
map("[", "LEADER", act.ActivateCopyMode)
map("c", { "SHIFT|CTRL", "SUPER" }, act.CopyTo("Clipboard"))
map("v", { "SHIFT|CTRL", "SUPER" }, act.PasteFrom("Clipboard"))
map("/", { "SHIFT|CTRL", "SUPER" }, act.Search("CurrentSelectionOrEmptyString"))
-- rotation
map("e", { "LEADER", "SUPER" }, act.RotatePanes("Clockwise"))
-- pickers
map(" ", "LEADER", act.QuickSelect)
map("o", { "LEADER", "SUPER" }, openUrl)
map("q", { "LEADER", "SUPER" }, act.PaneSelect({ alphabet = "asdfghjkl;" }))
map("R", { "LEADER", "SUPER" }, act.ReloadConfiguration)
map("u", "SHIFT|CTRL", act.CharSelect)
map("p", { "SHIFT|CTRL", "SHIFT|SUPER" }, act.ActivateCommandPalette)
-- view
map("Enter", "ALT", act.ToggleFullScreen)
map("-", { "CTRL", "SUPER" }, act.DecreaseFontSize)
map("=", { "CTRL", "SUPER" }, act.IncreaseFontSize)
map("0", { "CTRL", "SUPER" }, act.ResetFontSize)
-- switch fonts
-- map("f", "LEADER", act.EmitEvent("switch-font"))
-- debug
map("l", "SHIFT|CTRL", act.ShowDebugOverlay)

map(
	"r",
	{ "LEADER", "SUPER" },
	act.ActivateKeyTable({
		name = "resize_mode",
		one_shot = false,
	})
)

local key_tables = {
	copy_mode = {
		{ key = "q", action = act({ CopyMode = "Close" }) },
		{ key = "h", action = act({ CopyMode = "MoveLeft" }) },
		{ key = "j", action = act({ CopyMode = "MoveDown" }) },
		{ key = "k", action = act({ CopyMode = "MoveUp" }) },
		{ key = "l", action = act({ CopyMode = "MoveRight" }) },
		{ key = "u", action = act({ CopyMode = "MoveToScrollbackTop" }) },
		{ key = "d", action = act({ CopyMode = "MoveToScrollbackBottom" }) },

		{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{
			key = "y",
			action = act.Multiple({
				act.CopyTo("PrimarySelection"),
				act.ClearSelection,
				-- clear the selection mode, but remain in copy mode
				act({ CopyMode = "ClearSelectionMode" }),
			}),
		},
		-- Enter search mode to edit the pattern.
		-- When the search pattern is an empty string the existing pattern is preserved
		{ key = "/", mods = "NONE", action = act({ Search = { CaseSensitiveString = "" } }) },
		-- navigate any search mode results
		{ key = "n", mods = "NONE", action = act({ CopyMode = "NextMatch" }) },
		{ key = "N", mods = "SHIFT", action = act({ CopyMode = "PriorMatch" }) },
	},
	search_mode = {
		{ key = "Escape", mods = "NONE", action = act({ CopyMode = "ClearPattern" }) },
		-- Go back to copy mode when pressing enter, so that we can use unmodified keys like "n"
		-- to navigate search results without conflicting with typing into the search area.
		{ key = "Enter", mods = "NONE", action = "ActivateCopyMode" },
	},
	resize_mode = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- add a common escape sequence to all key tables
for k, _ in pairs(key_tables) do
	-- 	table.insert(key_tables[k], { key = "Escape", action = "PopKeyTable" })
	-- 	table.insert(key_tables[k], { key = "Enter", action = "PopKeyTable" })
	table.insert(key_tables[k], { key = "c", mods = "CTRL", action = "PopKeyTable" })
end

return {
	leader = { key = "f", mods = "CTRL", timeout_milliseconds = 5000 },
	keys = shortcuts,
	disable_default_key_bindings = true,
	key_tables = key_tables,
}
