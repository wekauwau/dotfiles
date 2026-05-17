-- Transparent apps
hl.window_rule({ match = { initial_title = "alacritty|kitty" }, opacity = "0.9 override 0.8 override" })

-- Layer rule for walker
hl.layer_rule({
	match = { namespace = "walker" },
	blur = true,
	dim_around = true,
	xray = true,
})

-- Smart gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

-- Floating windows
hl.window_rule({
	match = { class = "blueberry.py|float|htop|nvim|term|wiremix|yazi" },
	size = { 900, 650 },
	float = true,
	center = true,
})
hl.window_rule({ match = { class = "btop" }, size = { 1366, 768 }, float = true, center = true })
