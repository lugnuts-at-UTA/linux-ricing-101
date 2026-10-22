# Linux Ricing 101: rice Hyprland step by step

**Ricing** means customising your desktop until it looks and works exactly how you want:
colours, wallpaper, bar, launcher, animations, the lot (see r/unixporn for inspiration).
This guide takes Hyprland from its stock config to a finished, themed setup in 8 small
steps. Every step is a complete, working config in `stages/`, so you can copy any step
and continue from there.

| Before (stage 00) | After (stage 08) |
|---|---|
| ![stock Hyprland](assets/screenshots/00-stock.png) | ![finished rice](assets/screenshots/08-polish.png) |

The finished rice uses:

| Job | Program | Config file |
|---|---|---|
| Window manager | Hyprland | `~/.config/hypr/*.lua` |
| Wallpaper | hyprpaper | `~/.config/hypr/hyprpaper.conf` |
| Terminal | foot | `~/.config/foot/foot.ini` |
| Status bar | waybar | `~/.config/waybar/config.jsonc` + `style.css` |
| App launcher | fuzzel | `~/.config/fuzzel/fuzzel.ini` |
| Notifications | mako | `~/.config/mako/config` |
| Colours | Catppuccin Mocha | copied into each file above |

---

## Before you start

**1. Install the pieces** (Arch; other distros have the same package names or close):

```sh
sudo pacman -S hyprland foot waybar hyprpaper fuzzel mako \
  ttf-jetbrains-mono-nerd grim slurp wl-clipboard libnotify \
  brightnessctl wireplumber fastfetch
```

`ttf-jetbrains-mono-nerd` is a "Nerd Font": a normal font plus thousands of icons. The bar's
icons are characters from it, and without it they show up as empty boxes.

**2. Check which config format you have.** This guide was built on Hyprland 0.56.2, which
is configured in **Lua** (`~/.config/hypr/hyprland.lua`). Run `hyprctl version` and look in
`~/.config/hypr/`. If your install uses `hyprland.conf` instead, every idea here still
applies, but the syntax is different. Follow the wiki for your version
(https://wiki.hypr.land/).

**3. Get the configs:**

```sh
git clone https://github.com/lugnuts-at-UTA/linux-ricing-101.git
cd linux-ricing-101
```

**4. Back up what you have.** The stages overwrite these folders, so copy them first.
This matters most on Omarchy or any other pre-made setup, which ships its own versions:

```sh
for d in hypr foot waybar fuzzel mako; do
  [ -d ~/.config/$d ] && cp -r ~/.config/$d ~/.config/$d.bak
done
```

**5. How to use a stage.** Each `stages/NN-name/` folder mirrors `~/.config/`. To jump to
a stage, copy it over your config, and put the wallpaper where the configs expect it:

```sh
cp -r stages/05-bar/. ~/.config/
mkdir -p ~/Pictures/wallpapers && cp assets/wallpaper.png ~/Pictures/wallpapers/
```

Hyprland reloads by itself when its files change. Programs it starts at login (the bar,
the wallpaper, notifications) pick up a new stage the next time you log in.

**6. Three commands you'll use all the time:**

| Command | What it does |
|---|---|
| `hyprctl reload` | Re-read the config (Hyprland also reloads by itself when you save) |
| `hyprctl configerrors` | Show what's wrong if a red error bar appears at the top of the screen |
| `hyprctl clients` | List open windows with their `class`, which you need for window rules |

---

## Step 0: Stock Hyprland  ·  `stages/00-stock`

This is the example config Hyprland installs (`/usr/share/hypr/hyprland.lua`), unchanged
apart from the terminal. One 360-line file, the anime/logo wallpaper, kitty on
`SUPER+Q`, and no bar or launcher. It works, but it's nobody's desktop yet.

**Look at:** the sections in the file: `MONITORS`, `MY PROGRAMS`, `AUTOSTART`,
`LOOK AND FEEL`, `INPUT`, `KEYBINDINGS`, `WINDOWS AND WORKSPACES`. Ricing is mostly
editing these.

---

## Step 1: Make it yours  ·  `stages/01-basics`

**Goal:** the same desktop, split into small files that each have one job, with keybinds
that make sense to you.

**Files:** `hypr/hyprland.lua` now just loads the others:

```lua
require("monitors")   -- monitors.lua: screens, resolution, scale
require("input")      -- input.lua: keyboard layout, touchpad, gestures
require("looknfeel")  -- looknfeel.lua: gaps, borders, blur, animations
require("keybinds")   -- keybinds.lua: every shortcut
require("rules")      -- rules.lua: per-window behaviour
```

`programs.lua` holds the apps your keys launch, so you only change them in one place:

```lua
return {
    mainMod  = "SUPER",
    terminal = "foot",
}
```

**Keybinds** (`keybinds.lua`). The syntax is `hl.bind("MODS + KEY", dispatcher)`:

```lua
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(programs.terminal))  -- open a terminal
hl.bind(mod .. " + Q",      hl.dsp.window.close())               -- close window
hl.bind(mod .. " + F",      hl.dsp.window.fullscreen({ mode = "fullscreen" }))
```

Focus moves with the arrows **or** vim keys (`h j k l`), `mod+SHIFT+direction` swaps
windows, `mod+1..9` switches workspace, and `mod+S` toggles a scratchpad.

**Input** (`input.lua`): faster key repeat, natural touchpad scrolling, tap to click,
and Caps Lock as Escape.

**Goodbye anime wallpaper** (`looknfeel.lua`):

```lua
misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo   = true,
    background_color        = "rgb(1e1e2e)",
},
```

**Cheat sheet from here on:**

| Keys | Action |
|---|---|
| `SUPER + Return` | terminal |
| `SUPER + Q` | close window |
| `SUPER + F` / `V` | fullscreen / float |
| `SUPER + arrows` or `h j k l` | move focus |
| `SUPER + SHIFT + arrows` | swap windows |
| `SUPER + 1..9` / `SHIFT + 1..9` | go to / send to workspace |
| `SUPER + S` | scratchpad |
| `SUPER + drag` (left / right mouse) | move / resize |
| `SUPER + SHIFT + E` | quit Hyprland |

---

## Step 2: Wallpaper  ·  `stages/02-wallpaper`

**Install:** `hyprpaper`

**Files:** `hypr/hyprpaper.conf`:

```ini
wallpaper {
    monitor =
    path = ~/Pictures/wallpapers/wallpaper.png
    fit_mode = cover
}
splash = false
```

An empty `monitor` means "every screen". Then start it with Hyprland. Add
`hypr/autostart.lua` and `require("autostart")` to `hyprland.lua`:

```lua
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
end)
```

`hyprland.start` runs once at login, not on every config reload. That's why programs go
here and not at the top level.

**Try it live:** swap the wallpaper without editing anything:
`hyprctl hyprpaper wallpaper ', ~/Pictures/wallpapers/other.png'`

**Pick the wallpaper first.** The next step's colours should match it.

---

## Step 3: Colours and look  ·  `stages/03-colors`

This is the step that makes it look riced.

**One palette, used everywhere.** `hypr/palette.lua` holds the colours (Catppuccin Mocha
here, https://catppuccin.com/palette) plus a helper that turns them into Hyprland's format:

```lua
local palette = { base = "1e1e2e", mauve = "cba6f7", blue = "89b4fa", ... }
function palette.rgba(name, alpha)
    return "rgba(" .. palette[name] .. (alpha or "ff") .. ")"
end
return palette
```

**`looknfeel.lua` uses it:**

```lua
local c = require("palette")

general = {
    gaps_in = 6, gaps_out = 14, border_size = 3,
    col = {
        active_border   = { colors = { c.rgba("mauve"), c.rgba("blue") }, angle = 45 },
        inactive_border = c.rgba("surface0"),
    },
},
decoration = {
    rounding = 12,
    inactive_opacity = 0.9,                       -- unfocused windows fade a little
    blur = { enabled = true, size = 6, passes = 3 },  -- frosted glass behind see-through windows
},
```

**Animations** are bezier curves plus a style per event:

```lua
hl.curve("overshoot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows",    speed = 5, bezier = "overshoot", style = "popin 80%", enabled = true })
hl.animation({ leaf = "workspaces", speed = 5, bezier = "overshoot", style = "slidefade 20%", enabled = true })
```

Play with curves at https://cubic-bezier.com.

**Try it live:**
- change `gaps_out` to `40`, save, and the windows shrink away from the edges
- swap `"mauve"` for `"peach"` in `active_border`
- uncomment the last line (`borderangle` ... `style = "loop"`), then open a window or
  click one: its border gradient spins forever (borders already on screen keep still
  until they're refocused). It redraws constantly, so it costs battery.

---

## Step 4: Terminal  ·  `stages/04-terminal`

You'll stare at the terminal more than anything else, so it gets the same palette.

**Files:** `foot/foot.ini` (all options: `man foot.ini`):

```ini
[main]
font=JetBrainsMono Nerd Font:size=11
pad=14x14

[colors-dark]
alpha=0.85          # see-through; Hyprland's blur frosts what's behind
foreground=cdd6f4
background=1e1e2e
regular0=45475a
regular1=f38ba8
...
```

`regular0..7` and `bright0..7` are the 16 terminal colours every program uses. Catppuccin
publishes ready-made versions for almost every terminal (https://github.com/catppuccin).

**Check it:** `foot --check-config`. **Show it off:** `fastfetch`.

---

## Step 5: Status bar  ·  `stages/05-bar`

**Install:** `waybar`

**Files:** `waybar/config.jsonc` picks the modules and where they go:

```jsonc
"modules-left":   ["custom/logo", "hyprland/workspaces"],
"modules-center": ["clock"],
"modules-right":  ["pulseaudio", "network", "battery", "tray"],
```

`waybar/style.css` styles them with (GTK) CSS. The trick for the floating look is to make
the bar itself transparent and give each group its own rounded box:

```css
window#waybar { background: transparent; }
.modules-left, .modules-center, .modules-right {
  background: alpha(@base, 0.85);
  border: 2px solid @surface0;
  border-radius: 12px;
}
#workspaces button.active { color: @crust; background: @mauve; }
```

Add `hl.exec_cmd("waybar")` to `autostart.lua`. Then blur behind the bar with a **layer
rule** in `rules.lua`. Layers are bars, launchers, notifications and wallpapers
(list them with `hyprctl layers`):

```lua
hl.layer_rule({ name = "blur-waybar", match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.1 })
```

**Reload waybar after editing:** `pkill -SIGUSR2 waybar`.
**Debug the CSS live:** `GTK_DEBUG=interactive waybar`.
**Network shows a weird name?** Set `"interface"` in the network module to yours
(`ip -br link`; Wi-Fi usually starts with `wl`).

---

## Step 6: Launcher  ·  `stages/06-launcher`

**Install:** `fuzzel`

**Files:** `fuzzel/fuzzel.ini`. Colours are `RRGGBBAA`, and the last two digits are
opacity:

```ini
[main]
font=JetBrainsMono Nerd Font:size=12
prompt="❯ "
[colors]
background=1e1e2ee6
selection=45475aff
match=f38ba8ff
border=cba6f7ff
[border]
width=3
radius=12
```

Add `launcher = "fuzzel"` to `programs.lua`, then bind it:

```lua
hl.bind(mod .. " + Space", hl.dsp.exec_cmd(programs.launcher))
```

Plus a `blur-launcher` layer rule (`namespace = "launcher"`). **Check it:**
`fuzzel --check-config`.

---

## Step 7: Notifications  ·  `stages/07-notifications`

**Install:** `mako` (and `libnotify` for `notify-send`)

**Files:** `mako/config`:

```ini
font=JetBrainsMono Nerd Font 11
background-color=#1e1e2ee6
text-color=#cdd6f4
border-color=#cba6f7
border-size=2
border-radius=12
default-timeout=5000

[urgency=critical]
border-color=#fab387
default-timeout=0
```

Autostart `mako`, bind `mod+N` to `makoctl dismiss --all`, and add a `blur-notifications`
layer rule (`namespace = "notifications"`).

**Try it:** `notify-send "Lug Nuts" "Linux Ricing 101 starts now"`. After editing, run
`makoctl reload`.

---

## Step 8: Polish  ·  `stages/08-polish`

**Install:** `grim slurp wl-clipboard`

**Window rules** (`rules.lua`): "when a window like X opens, do Y". Find a window's
`class` with `hyprctl clients`:

```lua
-- small utility apps float in the middle instead of tiling
hl.window_rule({
    name  = "float-utilities",
    match = { class = "^(org.pulseaudio.pavucontrol|nm-connection-editor|blueman-manager)$" },
    float = true, center = true, size = { 900, 600 },
})

-- picture-in-picture video: small, bottom-right, on every workspace
hl.window_rule({
    name  = "pip",
    match = { title = "^(Picture.in.[Pp]icture)$" },
    float = true, pin = true, size = { 480, 270 },
    move  = { "monitor_w-500", "monitor_h-290" },
})
```

Window rule syntax changes between Hyprland versions. Always check
https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for yours.

**Smart gaps** (optional): four commented lines at the bottom of `rules.lua` remove gaps
and borders when a window is alone. Uncomment them to try it.

**Screenshots, so you can post your rice:**

| Keys | Result |
|---|---|
| `Print` or `SUPER + P` | drag a region, copied to the clipboard |
| `SHIFT + Print` or `SUPER + SHIFT + P` | whole screen, saved to `~/Pictures/Screenshots/` |

**Bar logo:** clicking the Arch logo in waybar now opens fuzzel (`"on-click": "fuzzel"`).

---

## Where to go next

- **Lock screen and idle:** `hyprlock` and `hypridle` (both on the Hyprland wiki).
- **Colours from your wallpaper:** `matugen` or `pywal` generate a palette from an image.
- **Keep your dotfiles in git:** put `~/.config/{hypr,waybar,foot,fuzzel,mako}` in a repo
  and symlink them with GNU `stow`. Then your rice survives reinstalls.
- **Read other people's configs:** r/unixporn posts usually link their dotfiles.

## Troubleshooting

| Problem | Fix |
|---|---|
| Red error bar at the top | `hyprctl configerrors` says which file and line |
| Want to test a config without breaking your session | `Hyprland --verify-config -c path/to/hyprland.lua` |
| Bar didn't appear | run `waybar` in a terminal and read the error |
| Icons are empty boxes | install `ttf-jetbrains-mono-nerd` and use it in the font settings |
| A key does nothing | `hyprctl binds` lists every bind Hyprland actually loaded |
| Messed everything up | `rm -r ~/.config/hypr && cp -r ~/.config/hypr.bak ~/.config/hypr` |
