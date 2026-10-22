-- Look and feel, now in our colours. Every option: https://wiki.hypr.land/Configuring/Basics/Variables/
local c = require("palette")

hl.config({
    general = {
        gaps_in     = 6,  -- between windows
        gaps_out    = 14, -- between windows and the screen edge
        border_size = 3,
        col = {
            active_border   = { colors = { c.rgba("mauve"), c.rgba("blue") }, angle = 45 },
            inactive_border = c.rgba("surface0"),
        },
        resize_on_border = true, -- drag a gap to resize
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 12,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.9, -- unfocused windows go slightly see-through

        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = c.rgba("crust", "ee"),
        },

        -- Blur is what makes see-through windows look like frosted glass.
        blur = {
            enabled  = true,
            size     = 6,
            passes   = 3,
            vibrancy = 0.17,
        },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        background_color        = c.rgba("crust"),
    },
})

-- Animations: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
-- A bezier curve's two points shape the motion; the overshoot one goes slightly past
-- the target and settles back, which reads as "bouncy".
hl.curve("overshoot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("smooth",    { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("linear",    { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windows",    enabled = true, speed = 5,  bezier = "overshoot", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3,  bezier = "smooth",    style = "popin 80%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 4,  bezier = "smooth" })
hl.animation({ leaf = "layers",     enabled = true, speed = 4,  bezier = "smooth",    style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5,  bezier = "overshoot", style = "slidefade 20%" })
hl.animation({ leaf = "border",     enabled = true, speed = 8,  bezier = "smooth" })

-- The flex: spin the border gradient forever. It redraws every frame, so it costs
-- battery. Uncomment it live, then open or focus a window and watch its border rotate.
-- hl.animation({ leaf = "borderangle", enabled = true, speed = 60, bezier = "linear", style = "loop" })
