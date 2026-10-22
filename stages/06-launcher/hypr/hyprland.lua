-- Linux Ricing 101, stage 06: an app launcher (fuzzel) on mainMod + Space.
-- Each require("name") loads name.lua from this folder (~/.config/hypr/).

require("monitors")
require("input")
require("looknfeel") -- looknfeel.lua pulls in palette.lua itself
require("keybinds")
require("rules")
require("autostart")
