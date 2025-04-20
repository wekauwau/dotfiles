-- require("smart-enter"):setup {
-- 	open_multi = true,
-- }

require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

-- require("git"):setup()

require("bookmarks"):setup({
	last_directory = { enable = true, persist = false },
	persist = "all",
	desc_format = "full",
	file_pick_mode = "parent",
	notify = { enable = false },
})

local yatline_theme = require("yatline-tokyo-night"):setup("night")
yatline_theme.section_separator = { open = "", close = "" }
yatline_theme.part_separator = { open = "|", close = "|" }
yatline_theme.inverse_separator = { open = "", close = "" }

require("yatline"):setup({
	theme = yatline_theme,

	tab_width = 25,
	tab_use_inverse = false,

	show_background = true,

	display_header_line = true,
	display_status_line = true,

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_name" },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "symlink" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})

require("yatline-symlink"):setup({
	symlink_color = "#c0caf5",
})
