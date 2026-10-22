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
