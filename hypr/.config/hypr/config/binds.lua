local cfg = require("config.binds.vars")
local mainMod, shiftMod = cfg.mainMod, cfg.shiftMod

require("config.binds.app")
require("config.binds.media")
require("config.binds.tiling")
require("config.binds.utilities")

hl.bind(shiftMod .. "CTRL + M", hl.dsp.exec_cmd("hyprshutdown"), { description = "Quit hyprland" })
