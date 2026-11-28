------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "eDP-1",
	mode = "1920x1200@75.0",
	position = "0x0",
	scale = "1.20",
	vrr = 1,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@75.0",
	position = "1280x0", -- Note: eDP-1 logical width is 1600 (1920 / 1.20); use "1600x0" to avoid overlap
	scale = "1.50",
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.00",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprland-session.target")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("vicinae server")
	hl.exec_cmd("stremio-server")
	hl.exec_cmd("qs")
end)

hl.on("hyprland.shutdown", function()
	os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("NIXOS_OZONE_WL", "1")
-- Cursor left default (unmodified)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 0,
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		blur = {
			enabled = true,
			size = 12,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		disable_hyprland_logo = false,
		force_default_wallpaper = 0,
		vrr = 1,
	},

	input = {
		kb_layout = "us",
		numlock_by_default = true,
		follow_mouse = 1,

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			disable_while_typing = true,
		},
	},

	gestures = {
		workspace_swipe_distance = 300,
		workspace_swipe_forever = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Trackpoint disabled (ported from niri)
hl.device({
	name = "*trackpoint*",
	enabled = false,
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "almostLinear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" })

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen-beta"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + SHIFT + F23", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("wl-mirror $(hyprctl monitors -j | jq -r '.[0].name')"))

-- Audio & Volume (Quickshell OSD integration)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh down"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/quickshell/scripts/volume.sh mic-mute"), { locked = true })
hl.bind("XF86Favorites", hl.dsp.exec_cmd("~/.config/quickshell/scripts/power-mode.sh"), { locked = true })

-- Media Controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Display Brightness (Quickshell OSD integration)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("~/.config/quickshell/scripts/brightness.sh +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("~/.config/quickshell/scripts/brightness.sh 5%-"),
	{ locked = true, repeating = true }
)

-- Window Management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + X", hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + C", hl.dsp.window.center())

-- Directional Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move Window within Workspace
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))

-- Monitor Navigation
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.focus({ monitor = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.focus({ monitor = "down" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ monitor = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ monitor = "down" }))

-- Move Window to Monitor
hl.bind(mainMod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "right" }))
hl.bind(mainMod .. " + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "up" }))
hl.bind(mainMod .. " + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "down" }))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "right" }))
hl.bind(mainMod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "up" }))
hl.bind(mainMod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "down" }))

-- Workspaces 1-10 (key "0" maps to workspace 10)
for i = 1, 10 do
	local key = tostring(i % 10)
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspaces (Scratchpads)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- Dedicated auto-launching terminal scratchpad on SUPER + ` (grave)
hl.on("workspace.created", function(ws)
	if ws.name == "special:terminal" and ws.is_empty then
		hl.exec_cmd("kitty", { workspace = "special:terminal silent" })
	end
end)
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("terminal"))

-- Relative Workspaces
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + Page_Up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + Page_Down", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + Page_Up", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + U", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + I", hl.dsp.window.move({ workspace = "-1" }))

-- Touchpad & Cursor Workspace Navigation
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "-1" }))
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Mouse Window Drag and Resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots (grim to ~/Pictures/Screenshots)
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		"mkdir -p ~/Pictures/Screenshots && grim \"$HOME/Pictures/Screenshots/Screenshot from $(date +'%Y-%m-%d %H-%M-%S').png\""
	)
)
hl.bind(
	"CTRL + Print",
	hl.dsp.exec_cmd(
		"mkdir -p ~/Pictures/Screenshots && grim \"$HOME/Pictures/Screenshots/Screenshot from $(date +'%Y-%m-%d %H-%M-%S').png\""
	)
)
hl.bind(
	"ALT + Print",
	hl.dsp.exec_cmd(
		'mkdir -p ~/Pictures/Screenshots && grim -g "$(hyprctl activewindow -j | jq -r \'"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])"\' )" "$HOME/Pictures/Screenshots/Screenshot from $(date +\'%Y-%m-%d %H-%M-%S\').png"'
	)
)

-- Session
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprctl dispatch dpms off"))

----------------------
---- WINDOW RULES ----
----------------------

hl.window_rule({
	name = "pip",
	match = { class = "zen-beta", title = "Picture-in-Picture" },
	float = true,
	opacity = 1.0,
})

hl.window_rule({
	name = "zen-beta",
	match = { class = "^(zen-beta)$" },
	opacity = 0.87,
})

hl.window_rule({
	name = "obsidian",
	match = { class = "md.obsidian.Obsidian" },
	opacity = 0.95,
})

hl.window_rule({
	name = "keepassxc",
	match = { class = "org.keepassxc.KeePassXC" },
	no_focus = true,
})

hl.window_rule({
	name = "gnome-secrets",
	match = { class = "org.gnome.World.Secrets" },
	no_focus = true,
})
