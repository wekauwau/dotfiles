-- Transparent apps
hl.window_rule({ match = { initial_title = "alacritty|kitty" }, opacity = "0.95 override 0.8 override" })

hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	animation = "slide right",
	dim_around = true,
})

hl.layer_rule({
	match = { namespace = "walker" },
	animation = "fade",
	dim_around = true,
})

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })
hl.window_rule({ match = { float = true }, border_size = 4 })

-- Floating windows
hl.window_rule({
	match = { class = "bluetuith|btop|float|htop|nvim|term|wiremix|yazi" },
	size = { 1180, 670 },
	float = true,
	center = true,
})
