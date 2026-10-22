-- https://wiki.hypr.land/Configuring/Basics/Monitors/
-- output = "" matches every monitor. List yours with: hyprctl monitors all
-- Example for a specific screen:
--   hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1.25 })
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto", -- or a number, e.g. 1.25
})
