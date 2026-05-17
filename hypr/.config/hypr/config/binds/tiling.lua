local cfg = require("config.binds.vars")
local mainMod = cfg.mainMod

local function run_script(script)
	return hl.dsp.exec_cmd(script)
end

local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
		if workspace == nil then
			return
		end
		local layout = workspace.tiled_layout
		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

hl.bind("ALT + grave", hl.dsp.exec_cmd("hypr_cycle_layout"), { description = "Next layout" })

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("amogus"), { description = "Toggle amogus workspace" })
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special:amogus" }),
	{ description = "Move window to amogus workspace" }
)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Switch to workspace " .. i })
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)
end

-- Cycle between active workspaces
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "m+1" }), { description = "Switch to next active workspace" })
hl.bind(
	mainMod .. " + SHIFT + TAB",
	hl.dsp.focus({ workspace = "m-1" }),
	{ description = "Switch to previous active workspace" }
)
hl.bind(
	mainMod .. " + grave", -- ` key
	hl.dsp.focus({ workspace = "previous_per_monitor" }),
	{ description = "Switch to last opened workspace" }
)

-- Cycle between windows
hl.bind(
	"ALT + TAB",
	layout_bind({
		dwindle = hl.dsp.window.cycle_next(),
		scrolling = hl.dsp.window.cycle_next(),
		monocle = hl.dsp.layout("cyclenext"),
	}),
	{ description = "Switch to next window" }
)
hl.bind(
	"ALT + SHIFT + TAB",
	layout_bind({
		dwindle = hl.dsp.window.cycle_next({ next = false, tiled = true }),
		scrolling = hl.dsp.window.cycle_next({ next = false, tiled = true }),
		monocle = hl.dsp.layout("cycleprev"),
	}),
	{ description = "Switch to previous window" }
)

-- Close / kill window
hl.bind(mainMod .. " + W", hl.dsp.window.close(), { description = "Close window" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.kill(), { description = "Kill window" })

-- Window state
hl.bind(mainMod .. " + P", hl.dsp.window.float(), { description = "Toggle floating window" })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo(), { description = "Toggle floating window" }) -- Dwindle
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen_state({ internal = 1, client = 0, action = "toggle" }),
	{ description = "Toggle maximized window" }
)
-- hl.bind(
-- 	mainMod .. " + F",
-- 	hl.dsp.window.fullscreen({ mode = "maximized" }),
-- 	{ description = "Toggle maximized window" }
-- )
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen({ mode = "fullscreen" }),
	{ description = "Toggle fullscreen window" }
)

hl.bind(
	mainMod .. " + G",
	layout_bind({
		scrolling = hl.dsp.layout("consume_or_expel next"),
	}),
	{ description = "Switch to previous window" }
)

hl.bind(
	mainMod .. " + SHIFT + G",
	layout_bind({
		scrolling = hl.dsp.layout("consume_or_expel prev"),
	}),
	{ description = "Switch to previous window" }
)

hl.bind(
	mainMod .. " + A",
	layout_bind({
		dwindle = hl.dsp.layout("movetoroot"),
	}),
	{ description = "Heheheha" }
)

hl.bind(
	mainMod .. " + SHIFT + A",
	layout_bind({
		dwindle = hl.dsp.layout("movetoroot active unstable"),
	}),
	{ description = "Hehehehe hahahaha" }
)
