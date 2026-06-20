local cfg = require("config.binds.vars")
local mainMod, shiftMod, menu = cfg.mainMod, cfg.shiftMod, cfg.menu

hl.bind(mainMod .. "SPACE", hl.dsp.exec_cmd(menu), { description = "Menu" })

hl.bind(mainMod .. "I", hl.dsp.exec_cmd("swaync-client -t"), { description = "Open notification center" })

hl.bind("CTRL + ALT + SHIFT + W", hl.dsp.exec_cmd("restart-walker"), { description = "Restart walker" })

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"), { description = "Screenshot (monitor)" })
hl.bind(mainMod .. "Print", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Screenshot (window)" })
hl.bind(shiftMod .. "Print", hl.dsp.exec_cmd("hyprshot -m region"), { description = "Screenshot (region)" })
