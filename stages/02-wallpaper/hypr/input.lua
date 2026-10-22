-- Keyboard, mouse and touchpad.
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    input = {
        kb_layout    = "us",
        kb_options   = "caps:escape", -- Caps Lock becomes Escape. Delete this line if you hate it.
        repeat_delay = 250,           -- ms before a held key starts repeating
        repeat_rate  = 40,            -- repeats per second

        follow_mouse = 1,             -- focus follows the mouse
        sensitivity  = 0,             -- -1.0 to 1.0, 0 = no change

        touchpad = {
            natural_scroll = true,    -- scroll like a phone
            tap_to_click   = true,
        },
    },
})

-- Three-finger swipe left/right switches workspaces.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
