local cfg = require("config.binds.vars")
local mainMod, browser, terminal, textEditorTUI, fileManagerTUI, passwordManager =
	cfg.mainMod, cfg.browser, cfg.terminal, cfg.textEditorTUI, cfg.fileManagerTUI, cfg.passwordManager

-- ╔╦╗  ╦ ╦  ╦
--  ║   ║ ║  ║
--  ╩   ╚═╝  ╩

-- Terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal), { description = "Terminal" })
hl.bind(
	mainMod .. " + SHIFT + RETURN",
	hl.dsp.exec_cmd(terminal .. " --class float"),
	{ description = "Floating Terminal" }
)

-- File manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(terminal .. fileManagerTUI), { description = "File Manager" })
hl.bind(
	mainMod .. " + SHIFT + E",
	hl.dsp.exec_cmd(terminal .. " --class yazi " .. fileManagerTUI),
	{ description = "File Manager" }
)

-- Task manager
hl.bind(
	mainMod .. " + T",
	hl.dsp.exec_cmd(terminal .. " --class htop -e htop"),
	{ description = "Floating task manager" }
)
hl.bind(
	mainMod .. " + SHIFT + T",
	hl.dsp.exec_cmd(terminal .. " --class btop -e btop"),
	{ description = "Task manager" }
)

-- Text editor
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. textEditorTUI), { description = "Text editor" })
hl.bind(
	mainMod .. " + SHIFT + N",
	hl.dsp.exec_cmd(terminal .. " --class nvim " .. textEditorTUI),
	{ description = "Text editor (nvim)" }
)

-- ╔═╗  ╦ ╦  ╦
-- ║ ╦  ║ ║  ║
-- ╚═╝  ╚═╝  ╩

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser), { description = "Browser" })
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd(passwordManager), { description = "Password Manager" })
