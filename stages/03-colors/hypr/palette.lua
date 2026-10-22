-- One palette, used everywhere: Catppuccin Mocha (https://catppuccin.com/palette).
-- Change these hex values to recolour Hyprland. The terminal, bar, launcher and
-- notifications keep their own copy of the same colours in their own config files.
local palette = {
    crust    = "11111b",
    mantle   = "181825",
    base     = "1e1e2e",
    surface0 = "313244",
    surface1 = "45475a",
    overlay0 = "6c7086",
    text     = "cdd6f4",
    mauve    = "cba6f7",
    pink     = "f5c2e7",
    blue     = "89b4fa",
    lavender = "b4befe",
    teal     = "94e2d5",
    green    = "a6e3a1",
    yellow   = "f9e2af",
    peach    = "fab387",
    red      = "f38ba8",
}

-- palette.rgba("mauve", "ee") returns "rgba(cba6f7ee)", the format Hyprland wants.
-- The second argument is the alpha in hex: "ff" is solid, "00" is invisible.
function palette.rgba(name, alpha)
    return "rgba(" .. palette[name] .. (alpha or "ff") .. ")"
end

return palette
