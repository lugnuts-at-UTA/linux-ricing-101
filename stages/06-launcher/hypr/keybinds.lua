-- Keybinds. Syntax: hl.bind("MODS + KEY", dispatcher, options)
-- Dispatchers: https://wiki.hypr.land/Configuring/Basics/Dispatchers/
local programs = require("programs")
local mod      = programs.mainMod

-- Apps
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mod .. " + Space",  hl.dsp.exec_cmd(programs.launcher))
hl.bind(mod .. " + R",      hl.dsp.exec_cmd(programs.launcher)) -- the stock config's launcher key

-- Windows
hl.bind(mod .. " + Q",         hl.dsp.window.close())
hl.bind(mod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + T",         hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())

-- Focus and swap windows with the arrows or vim keys (h j k l).
local directions = {
    left = "l", right = "r", up = "u", down = "d",
    h    = "l", l     = "r", k  = "u", j    = "d",
}
for key, dir in pairs(directions) do
    hl.bind(mod .. " + " .. key,             hl.dsp.focus({ direction = dir }))
    hl.bind(mod .. " + SHIFT + " .. key,     hl.dsp.window.swap({ direction = dir }))
end

-- Workspaces 1-9: mod+N goes there, mod+SHIFT+N sends the window there.
for i = 1, 9 do
    hl.bind(mod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad: a hidden workspace that slides over whatever you're doing.
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- Drag windows with mod + left mouse, resize with mod + right mouse.
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop volume and brightness keys (work on the lock screen too).
local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      media)
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     media)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  media)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  media)
