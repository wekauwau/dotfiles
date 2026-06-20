-- Only display the OSD on the currently focused monitor
local osdClient = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(osdClient .. " --output-volume 5"),
	{ locked = true, repeating = true, description = "Volume +5%" }
)
hl.bind(
	"ALT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(osdClient .. " --output-volume 1"),
	{ locked = true, repeating = true, description = "Volume +1%" }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osdClient .. " --output-volume -5"),
	{ locked = true, repeating = true, description = "Volume -5%" }
)
hl.bind(
	"ALT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osdClient .. " --output-volume -1"),
	{ locked = true, repeating = true, description = "Volume -1%" }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(osdClient .. " --output-volume mute-toggle"),
	{ locked = true, description = "Toggle audio mute" }
)
-- hl.bind(
-- 	"XF86AudioMicMute",
-- 	hl.dsp.exec_cmd(osdClient .. " --input-volume mute-toggle"),
-- 	{ locked = true, description = "Toggle mic mute" }
-- )
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && " .. osdClient .. " --input-volume mute-toggle"),
	{ locked = true, description = "Toggle mic mute" }
)

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(osdClient .. " --brightness +5"),
	{ locked = true, repeating = true, description = "Brightness +5%" }
)
hl.bind(
	"ALT + XF86MonBrightnessUp",
	hl.dsp.exec_cmd(osdClient .. " --brightness +1"),
	{ locked = true, repeating = true, description = "Brightness +1%" }
)

hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osdClient .. " --brightness -5"),
	{ locked = true, repeating = true, description = "Brightness -5%" }
)
hl.bind(
	"ALT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osdClient .. " --brightness -1"),
	{ locked = true, repeating = true, description = "Brightness -1%" }
)
