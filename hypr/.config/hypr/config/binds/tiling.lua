local cfg = require("config.binds.vars")
local mainMod, shiftMod = cfg.mainMod, cfg.shiftMod

local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
		if not workspace then
			return
		end

		local layout = workspace.tiled_layout
		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

hl.bind(shiftMod .. "L", function()
	-- local layouts = { "dwindle", "master", "monocle", "scrolling" }
	local layouts = { "monocle", "scrolling" }
	local workspace = hl.get_active_workspace()
	local next_layout = "monocle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
end, { description = "Cycle layout for current workspace" })

hl.bind(mainMod .. "Q", hl.dsp.workspace.toggle_special("adios"), { description = "Toggle adios workspace" })
hl.bind(
	shiftMod .. "Q",
	hl.dsp.window.move({ workspace = "special:adios" }),
	{ description = "Move window to adios workspace" }
)
hl.bind(mainMod .. "E", hl.dsp.workspace.toggle_special("amogus"), { description = "Toggle amogus workspace" })
hl.bind(
	shiftMod .. "E",
	hl.dsp.window.move({ workspace = "special:amogus" }),
	{ description = "Move window to amogus workspace" }
)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. key, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
	hl.bind(shiftMod .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end

hl.bind(mainMod .. "TAB", hl.dsp.focus({ workspace = "m+1" }), { description = "Switch to next active workspace" })
hl.bind(shiftMod .. "TAB", hl.dsp.focus({ workspace = "m-1" }), { description = "Switch to previous active workspace" })
hl.bind(
	mainMod .. "GRAVE", -- ` key
	hl.dsp.focus({ workspace = "previous_per_monitor" }),
	{ description = "Switch to last opened workspace" }
)

hl.bind(
	"ALT + TAB",
	layout_bind({
		dwindle = hl.dsp.window.cycle_next(),
		master = hl.dsp.layout("cyclenext"),
		monocle = hl.dsp.layout("cyclenext"),
		scrolling = hl.dsp.window.cycle_next(),
	}),
	{ description = "Switch to next window" }
)
hl.bind(
	"ALT + SHIFT + TAB",
	layout_bind({
		dwindle = hl.dsp.window.cycle_next({ next = false, tiled = true }),
		master = hl.dsp.layout("cycleprev"),
		monocle = hl.dsp.layout("cycleprev"),
		scrolling = hl.dsp.window.cycle_next({ next = false, tiled = true }),
	}),
	{ description = "Switch to previous window" }
)
hl.bind(
	mainMod .. "W",
	layout_bind({
		scrolling = hl.dsp.layout("focus u"),
	}),
	{ description = "Switch to up window" }
)
hl.bind(
	mainMod .. "S",
	layout_bind({
		scrolling = hl.dsp.layout("focus d"),
	}),
	{ description = "Switch to down window" }
)
hl.bind(
	mainMod .. "A",
	layout_bind({
		scrolling = hl.dsp.layout("focus l"),
	}),
	{ description = "Switch to left window" }
)
hl.bind(
	shiftMod .. "A",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol l"),
	}),
	{ description = "Swap left" }
)
hl.bind(
	mainMod .. "D",
	layout_bind({
		scrolling = hl.dsp.layout("focus r"),
	}),
	{ description = "Switch to right window" }
)
hl.bind(
	shiftMod .. "D",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol r"),
	}),
	{ description = "Swap right" }
)

hl.bind(mainMod .. "U", hl.dsp.window.close(), { description = "Close window" })
hl.bind(shiftMod .. "U", hl.dsp.window.kill(), { description = "Kill window" })

-- Window state
hl.bind(mainMod .. "P", hl.dsp.window.float(), { description = "Toggle floating window" })
hl.bind(
	mainMod .. "F",
	hl.dsp.window.fullscreen_state({ internal = 1, client = 0, action = "toggle" }),
	{ description = "Toggle maximized window" }
)
hl.bind(
	shiftMod .. "F",
	hl.dsp.window.fullscreen({ mode = "fullscreen" }),
	{ description = "Toggle fullscreen window" }
)

-- Window group
hl.bind(
	mainMod .. "G",
	layout_bind({
		scrolling = hl.dsp.layout("consume_or_expel next"),
	}),
	{ description = "Group/ungroup next" }
)
hl.bind(
	shiftMod .. "G",
	layout_bind({
		scrolling = hl.dsp.layout("consume_or_expel prev"),
	}),
	{ description = "Group/ungroup previous" }
)

-- Window resize
hl.bind(
	mainMod .. "EQUAL",
	layout_bind({
		scrolling = hl.dsp.layout("colresize +conf"),
	}),
	{ description = "Window size++" }
)
hl.bind(
	mainMod .. "MINUS",
	layout_bind({
		scrolling = hl.dsp.layout("colresize -conf"),
	}),
	{ description = "Window size--" }
)
