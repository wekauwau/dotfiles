hl.on("hyprland.start", function()
	local x = hl.exec_cmd

	x("systemctl --user start hyprpolkitagent")
	x("hypridle")
	x("mako")
	x("waybar")
	x("swayosd-server")
	x("elephant")
	x("walker --gapplication-service")
	x("systemctl --user start hyprpolkitagent")
	x("sleep 2 && nm-applet --indicator &")
end)
