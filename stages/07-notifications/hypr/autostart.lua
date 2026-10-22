-- Programs that start once, when Hyprland starts (not on every config reload).
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper") -- wallpaper, configured in hyprpaper.conf next to this file
    hl.exec_cmd("waybar")    -- status bar, configured in ~/.config/waybar/
    hl.exec_cmd("mako")      -- notifications, configured in ~/.config/mako/config
end)
