-- Show symlink in status bar
-- https://yazi-rs.github.io/docs/tips#symlink-in-status
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

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
