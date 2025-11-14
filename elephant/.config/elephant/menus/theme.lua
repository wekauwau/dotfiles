Name = "theme"
NamePretty = "Change Theme"
Icon = "appearance-symbolic"
Action = "notify-send %VALUE%"
-- SearchName = true
Cache = false

local function is_light_mode(path)
	local f = io.popen('ls -1 "' .. path .. '" 2>/dev/null')
	if not f then
		return false
	end

	for line in f:lines() do
		if line == "light.mode" then
			f:close()
			return true
		end
	end

	f:close()
	return false
end

local function is_dir(path)
	return os.execute('[ -d "' .. path .. '" ] > /dev/null 2>&1')
end

local function list_themes()
	local path = os.getenv("HOME") .. "/.local/share/my-themes"
	local dirs = {}
	local p = io.popen('ls -1 "' .. path .. '"')
	if not p then
		return dirs
	end

	for dir in p:lines() do
		local theme = {}
		local full = path .. "/" .. dir

		if is_dir(full) then
			theme.name = dir
			if is_light_mode(full) then
				theme.light = true
			else
				theme.light = false
			end

			table.insert(dirs, theme)
		end
	end

	p:close()
	return dirs
end

local function readlink(path)
	local f = io.popen('readlink -f "' .. path .. '"')
	local result = f:read("*l")
	f:close()

	return result:match("([^/]+)$")
end

function GetEntries()
	local THEME_CURRENT = readlink(os.getenv("HOME") .. "/.local/state/my-current-theme")
	local entries = {}

	for _, theme in ipairs(list_themes()) do
		local entry = {
			Text = theme.name,
			Actions = {
				activate = string.format("set-theme %s", theme.name),
			},
		}

		if theme.light then
			entry.Icon = "weather-clear-symbolic"
		else
			entry.Icon = "weather-clear-night-symbolic"
		end

		if theme.name == THEME_CURRENT then
			entry.State = { "current" }
			entry.Subtext = "Current theme"
		end

		table.insert(entries, entry)
	end

	return entries
end
