-- Window rules: "when a window matching X opens, do Y".
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Find a window's class with: hyprctl clients

-- Apps can't maximize themselves and break your tiling.
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland (from the stock config).
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Small utility apps float in the middle instead of being tiled to half the screen.
hl.window_rule({
    name   = "float-utilities",
    match  = { class = "^(org.pulseaudio.pavucontrol|nm-connection-editor|blueman-manager|xdg-desktop-portal-gtk)$" },
    float  = true,
    center = true,
    size   = { 900, 600 },
})

-- Open/Save dialogs float too.
hl.window_rule({
    name   = "float-file-dialogs",
    match  = { title = "^(Open File|Open Folder|Save As|Save File).*" },
    float  = true,
    center = true,
})

-- Picture-in-picture video: small, bottom-right corner, visible on every workspace.
hl.window_rule({
    name  = "pip",
    match = { title = "^(Picture.in.[Pp]icture)$" },
    float = true,
    pin   = true,
    size  = { 480, 270 },
    move  = { "monitor_w-500", "monitor_h-290" },
})

-- "Smart gaps": no gaps, border or rounding when a window is alone on its workspace.
-- Uncomment all four lines to try it (this comes from Hyprland's stock config).
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })

-- Layer rules are window rules for "layers": bars, launchers, notifications, wallpapers.
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules   (list layers: hyprctl layers)

-- Frost the bar. ignore_alpha skips fully transparent pixels, so only the pills blur.
hl.layer_rule({
    name         = "blur-waybar",
    match        = { namespace = "waybar" },
    blur         = true,
    ignore_alpha = 0.1,
})

-- Same frosted glass behind the launcher (fuzzel's layer is called "launcher").
hl.layer_rule({
    name         = "blur-launcher",
    match        = { namespace = "launcher" },
    blur         = true,
    ignore_alpha = 0.1,
})

-- And behind notifications (mako's layer is called "notifications").
hl.layer_rule({
    name         = "blur-notifications",
    match        = { namespace = "notifications" },
    blur         = true,
    ignore_alpha = 0.1,
})
