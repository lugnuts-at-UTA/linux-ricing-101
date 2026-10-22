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
