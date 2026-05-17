local cfg = require("config.binds.vars")
local mainMod, menu = cfg.mainMod, cfg.menu

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu), { description = "Menu" })

-- Notifications
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd("makoctl dismiss"), { description = "Dismiss last notification" })
hl.bind(
	mainMod .. " + SHIFT + COMMA",
	hl.dsp.exec_cmd("makoctl dismiss --all"),
	{ description = "Dismiss all notifications" }
)
local toggleSilencingNotification =
	[[makoctl mode -t do-not-disturb && makoctl mode | grep -q "do-not-disturb" && notify-send "Silenced notifications" || notify-send "Enabled notifications"]]
hl.bind(
	mainMod .. " + CTRL + COMMA",
	hl.dsp.exec_cmd(toggleSilencingNotification),
	{ description = "Toggle silencing notifications" }
)

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("restart-walker"), { description = "Restart walker" })

-- Screenshot
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("screenshot full"), { description = "Screenshot (fullscreen)" })
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("screenshot partial"), { description = "Screenshot (partial)" })
