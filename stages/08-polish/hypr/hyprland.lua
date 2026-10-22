-- Linux Ricing 101, stage 08: polish. Window rules, screenshots, a clickable bar logo.
-- Each require("name") loads name.lua from this folder (~/.config/hypr/).

require("monitors")
require("input")
require("looknfeel") -- looknfeel.lua pulls in palette.lua itself
require("keybinds")
require("rules")
require("autostart")
