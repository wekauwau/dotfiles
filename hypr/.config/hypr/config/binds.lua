local cfg = require("config.binds.vars")
local mainMod = cfg.mainMod

require("config.binds.app")
require("config.binds.media")
require("config.binds.tiling")
require("config.binds.utilities")

-- hl.bind(mainMod .. " + CTRL + M", hl.dsp.exit(), { description = "Quit Hyprland" })
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd("hyprshutdown"), { description = "Quit Hyprland" })
