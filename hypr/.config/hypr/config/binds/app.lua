local cfg = require("config.binds.vars")
local mainMod, shiftMod, terminal, textEditorTUI, fileManagerTUI, passwordManager =
	cfg.mainMod, cfg.shiftMod, cfg.terminal, cfg.textEditorTUI, cfg.fileManagerTUI, cfg.passwordManager

-- ╔╦╗  ╦ ╦  ╦
--  ║   ║ ║  ║
--  ╩   ╚═╝  ╩

hl.bind(mainMod .. "RETURN", hl.dsp.exec_cmd(terminal), { description = "Terminal" })
hl.bind(shiftMod .. "RETURN", hl.dsp.exec_cmd(terminal .. " --class float"), { description = "Floating Terminal" })

hl.bind(mainMod .. "O", hl.dsp.exec_cmd(terminal .. fileManagerTUI), { description = "File manager" })
hl.bind(
	shiftMod .. "O",
	hl.dsp.exec_cmd(terminal .. " --class yazi " .. fileManagerTUI),
	{ description = "Floating file manager" }
)

hl.bind(mainMod .. "J", hl.dsp.exec_cmd(terminal .. " --class htop -e htop"), { description = "Task manager (htop)" })
hl.bind(shiftMod .. "J", hl.dsp.exec_cmd(terminal .. " --class btop -e btop"), { description = "Task manager (btop)" })

hl.bind(mainMod .. "N", hl.dsp.exec_cmd(terminal .. textEditorTUI), { description = "Text editor" })
hl.bind(
	shiftMod .. "N",
	hl.dsp.exec_cmd(terminal .. " --class nvim " .. textEditorTUI),
	{ description = "Floating text editor" }
)

-- ╔═╗  ╦ ╦  ╦
-- ║ ╦  ║ ║  ║
-- ╚═╝  ╚═╝  ╩

hl.bind(mainMod .. "SLASH", hl.dsp.exec_cmd(passwordManager), { description = "Password manager" })
