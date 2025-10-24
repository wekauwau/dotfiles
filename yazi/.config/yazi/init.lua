require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("bookmarks"):setup({
	last_directory = { enable = true, persist = false },
	persist = "all",
	desc_format = "full",
	file_pick_mode = "parent",
	notify = { enable = false },
})

require("git"):setup()
