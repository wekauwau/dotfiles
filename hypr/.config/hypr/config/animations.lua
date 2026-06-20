hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.70 }, { 0.05, 1.00 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.30, 0.00 }, { 0.80, 0.15 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.10, 1.00 }, { 0.00, 1.00 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1.00, 0.07 } } })
hl.curve("windMove", { type = "bezier", points = { { 0.83, 0.00 }, { 0.17, 1.00 } } })

hl.curve("easy", { type = "spring", mass = 0.6, stiffness = 70.26, dampening = 15.8 })

hl.animation({ leaf = "borderangle", enabled = false })
hl.animation({ leaf = "windows", enabled = true, speed = 2.0, spring = "easy", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.0, spring = "easy", style = "popin 10%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.0, bezier = "menu_decel", style = "popin 90%" })

hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fade", enabled = false, speed = 2.0, bezier = "md3_decel" })
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 2.0, bezier = "windMove", style = "slidevert" })
hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 3.0,
	bezier = "md3_decel",
	style = "slidefadevert 15%",
})
