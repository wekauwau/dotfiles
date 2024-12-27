-- require("smart-enter"):setup {
-- 	open_multi = true,
-- }

require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("git"):setup()

require("bookmarks"):setup({
	last_directory = { enable = true, persist = false },
	persist = "all",
	desc_format = "full",
	file_pick_mode = "parent",
	notify = { enable = false },
})

local yatline_theme = require("yatline-tokyo-night"):setup("night")

require("yatline"):setup({
	theme = yatline_theme,
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = "black",
		bg_mode = {
			normal = "#a89984",
			select = "#d79921",
			un_set = "#d65d0e",
		},
	},
	style_b = { bg = "#665c54", fg = "#ebdbb2" },
	style_c = { bg = "#3c3836", fg = "#a89984" },

	permissions_t_fg = "green",
	permissions_r_fg = "yellow",
	permissions_w_fg = "red",
	permissions_x_fg = "cyan",
	permissions_s_fg = "darkgray",

	tab_width = 25,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = "yellow" },
	copied = { icon = "", fg = "green" },
	cut = { icon = "", fg = "red" },

	total = { icon = "󰮍", fg = "yellow" },
	succ = { icon = "", fg = "green" },
	fail = { icon = "", fg = "red" },
	found = { icon = "󰮕", fg = "blue" },
	processed = { icon = "󰐍", fg = "green" },

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
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_b = {
				{ type = "coloreds", custom = false, name = "count" },
			},
			section_c = {
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "coloreds", custom = false, name = "created_time" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_name" },
				{ type = "coloreds", custom = false, name = "symlink" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_b = {
				{ type = "coloreds", custom = false, name = "modified_time" },
			},
			section_c = {
				-- INFO: Disabled
				-- { type = "coloreds", custom = false, name = "githead" },
			},
		},
	},
})

require("yatline-created-time"):setup()
-- INFO: Seems not working
-- require("yatline-githead"):setup()
require("yatline-modified-time"):setup()
require("yatline-symlink"):setup()
