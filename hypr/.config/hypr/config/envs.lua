-- hl.env("HYPRLAND_CONFIG", "/path/to/hyprland.lua")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")

-- Explicitly set XDG environment variables
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
