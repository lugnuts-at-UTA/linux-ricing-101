-- Linux Ricing 101, stage 04: a themed terminal (foot/foot.ini). Hyprland itself is unchanged.
-- Each require("name") loads name.lua from this folder (~/.config/hypr/).

require("monitors")
require("input")
require("looknfeel") -- looknfeel.lua pulls in palette.lua itself
require("keybinds")
require("rules")
require("autostart")
