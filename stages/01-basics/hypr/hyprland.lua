-- Linux Ricing 101, stage 01: same Hyprland, split into files you can find things in.
-- Each require("name") loads name.lua from this folder (~/.config/hypr/).
-- Hyprland reloads on save, so edit any of these and watch it change.

require("monitors")
require("input")
require("looknfeel")
require("keybinds")
require("rules")
