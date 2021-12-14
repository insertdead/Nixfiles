{self, config, pkgs, lib, utils, ... }:
let

  myPolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  polybarConfig = ''
[colors]
background = #2e3440
background-alt = $${xrdb:color0}
foreground = $${xrdb:color7}
foreground-alt = $${xrdb:color15}
primary = $${xrdb:color3}
secondary = $${xrdb:color1}
alert = $${xrdb:color14}

[bar/main]
monitor = $${env:MONITOR:eDP-1}
width = 1900
height = 25
offset-x = 10
offset-y = 7
radius = 6.0
fixed-center = false

background = $${colors.background}
foreground = $${colors.foreground}

line-size = 3
line-color = $${colors.secondary}

border-size = 0
border-color = $${colors.background}
border-left-color = $${xrdb:color11}
border-right-color = $${xrdb:color11}

padding-left = 0
padding-right = 2

module-margin-left = 1
module-margin-right = 1

; font-N = <fontconfig pattern>;<vertical offset>
font-0 = JetBrainsMono Nerd Font:pixelsize=11;1
font-1 = Noto Color Emoji:size=10:antialias=false;0

modules-left = bspwm
; modules-center = mpd
modules-right = filesystem pulseaudio xkeyboard memory cpu wlan date battery powermenu

tray-padding = 2
;; Workaround for #651
Padding-left = 40
tray-position = center
tray-detatched = true
tray-offset-x = 999
;tray-background = #0063ff

wm-restack = bspwm

;override-redirect = true

scroll-up = bspwm-desknext
scroll-down = bspwm-deskprev

cursor-click = pointer
cursor-scroll = ns-resize

[module/xwindow]
type = internal/xwindow
label = %title:0:30:...%

[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock

format-prefix = " "
format-prefix-foreground = $${colors.foreground-alt}
format-prefix-underline = $${colors.secondary}

label-layout = %layout%
label-layout-underline = $${colors.secondary}

label-indicator-padding = 2
label-indicator-margin = 1
label-indicator-background = $${colors.secondary}
label-indicator-underline = $${colors.secondary}

[module/filesystem]
type = internal/fs
interval = 25

mount-0 = /

label-mounted = %{F#61afef} %{F-}%percentage_used%%
label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = $${colors.foreground-alt}

[module/bspwm]
type = internal/bspwm

label-focused = %index%
label-focused-background = $${colors.background-alt}
label-focused-underline= $${colors.primary}
label-focused-padding = 2

label-occupied = %index%
label-occupied-padding = 2

label-urgent = %index%!
label-urgent-background = $${colors.alert}
label-urgent-padding = 2

label-empty = %index%
label-empty-foreground = $${colors.foreground-alt}
label-empty-padding = 2

; Separator in between workspaces
; label-separator = |

[module/i3]
type = internal/i3
format = <label-state> <label-mode>
index-sort = true
wrapping-scroll = false

; Only show workspaces on the same output as the bar
;pin-workspaces = true

label-mode-padding = 2
label-mode-foreground = #000
label-mode-background = $${colors.primary}

; focused = Active workspace on focused monitor
label-focused = %index%
label-focused-background = $${colors.background-alt}
label-focused-underline= $${colors.primary}
label-focused-padding = 2

; unfocused = Inactive workspace on any monitor
label-unfocused = %index%
label-unfocused-padding = 2

; visible = Active workspace on unfocused monitor
label-visible = %index%
label-visible-background = $${self.label-focused-background}
label-visible-underline = $${self.label-focused-underline}
label-visible-padding = $${self.label-focused-padding}

; urgent = Workspace with urgency hint set
label-urgent = %index%
label-urgent-background = $${colors.alert}
label-urgent-padding = 2

; Separator in between workspaces
; label-separator = |


[module/mpd]
type = internal/mpd
format-online = <label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>

icon-prev = 玲
icon-stop = 栗
icon-play = 契
icon-pause = 
icon-next = 怜

label-song-maxlen = 60
label-song-ellipsis = true

[module/xbacklight]
type = internal/xbacklight

format = <label> <bar>
label = BL

bar-width = 10
bar-indicator = |
bar-indicator-foreground = #fff
bar-indicator-font = 2
bar-fill = ─
bar-fill-font = 2
bar-fill-foreground = #9f78e1
bar-empty = ─
bar-empty-font = 2
bar-empty-foreground = $${colors.foreground-alt}

[module/backlight-acpi]
inherit = module/xbacklight
type = internal/backlight
card = intel_backlight

[module/cpu]
type = internal/cpu
interval = 2
format-prefix = " "
format-prefix-foreground = $${colors.foreground-alt}
format-underline = $${xrdb:color1}
label = %percentage:2%%

[module/memory]
type = internal/memory
interval = 2
format-prefix = "﬙ "
format-prefix-foreground = $${colors.foreground-alt}
format-underline = #4bffdc
label = %percentage_used%%

[module/wlan]
type = internal/network
interface = wlp0s20f3
interval = 3.0

format-connected = <ramp-signal> <label-connected>
format-connected-underline = #9f78e1
label-connected = %essid%

; format-disconnected =
format-disconnected = 睊 <label-disconnected>
;format-disconnected-underline = $${self.format-connected-underline}
label-disconnected = %ifname% disconnected
;label-disconnected-foreground = $${colors.foreground-alt}

ramp-signal-0 = 睊
ramp-signal-1 = 直
ramp-signal-2 = 直
ramp-signal-3 = 直
ramp-signal-4 = 直
ramp-signal-0-foreground = $${xrdb:color1}
ramp-signal-1-foreground = $${xrdb:color9}
ramp-signal-2-foreground = $${xrdb:color3}
ramp-signal-3-foreground = $${xrdb:color2}
ramp-signal-4-foreground = $${xrdb:color2}

[module/eth]
type = internal/network
interface = virbr0
interval = 3.0

format-connected-underline = $${xrdb:color2}
format-connected-prefix = " "
format-connected-prefix-foreground = $${colors.foreground-alt}
label-connected = %local_ip%

; format-disconnected =
format-disconnected =  <label-disconnected>
;format-disconnected-underline = $${self.format-connected-underline}
label-disconnected = %ifname% disconnected
;label-disconnected-foreground = $${colors.foreground-alt}

[module/date]
type = internal/date
interval = 5

date = " %m %d %Y"
date-alt = " %Y-%m-%d"

time = %H:%M
time-alt = %H:%M:%S

format-prefix = " "
format-prefix-foreground = $${colors.foreground-alt}
format-underline = #0a6cf5

label = %time% %date% 

[module/pulseaudio]
type = internal/pulseaudio

; format-volume = <label-volume> <bar-volume>
format-volume = <label-volume>
label-volume = 墳 %percentage%%
label-volume-foreground = $${root.foreground}

label-muted = ﱝ muted
label-muted-foreground = $${xrdb:color12}

bar-volume-width = 10
bar-volume-foreground-0 = $${xrdb:color2}
bar-volume-foreground-1 = $${xrdb:color2}
bar-volume-foreground-2 = $${xrdb:color2}
bar-volume-foreground-3 = $${xrdb:color2}
bar-volume-foreground-4 = $${xrdb:color2}
bar-volume-foreground-5 = $${xrdb:color9}
bar-volume-foreground-6 = $${xrdb:color1}
bar-volume-gradient = false
bar-volume-indicator = |
bar-volume-indicator-font = 2
bar-volume-fill = ─
bar-volume-fill-font = 2
bar-volume-empty = ─
bar-volume-empty-font = 2
bar-volume-empty-foreground = $${colors.foreground-alt}

[module/alsa]
type = internal/alsa

format-volume = <label-volume> <bar-volume>
label-volume = VOL
label-volume-foreground = $${root.foreground}

format-muted-prefix = " "
format-muted-foreground = $${colors.foreground-alt}
label-muted = sound muted

bar-volume-width = 10
bar-volume-foreground-0 = $${xrdb:color2}
bar-volume-foreground-1 = $${xrdb:color2}
bar-volume-foreground-2 = $${xrdb:color2}
bar-volume-foreground-3 = $${xrdb:color2}
bar-volume-foreground-4 = $${xrdb:color2}
bar-volume-foreground-5 = $${xrdb:color9}
bar-volume-foreground-6 = $${xrdb:color1}
bar-volume-gradient = false
bar-volume-indicator = |
bar-volume-indicator-font = 2
bar-volume-fill = ─
bar-volume-fill-font = 2
bar-volume-empty = ─
bar-volume-empty-font = 2
bar-volume-empty-foreground = $${colors.foreground-alt}

[module/battery]
type = internal/battery
battery = CMB0
adapter = ADP1
full-at = 98

format-charging = <animation-charging> <label-charging>
format-charging-underline = #ffb52a

format-discharging = <ramp-capacity> <label-discharging>
format-discharging-underline = $${self.format-charging-underline}

format-full-prefix = " "
format-full-prefix-foreground = $${colors.foreground-alt}
format-full-underline = $${self.format-charging-underline}

ramp-capacity-0 = 
ramp-capacity-1 = 
ramp-capacity-2 = 
ramp-capacity-3 = 
ramp-capacity-4 = 
ramp-capacity-5 = 
ramp-capacity-6 = 
ramp-capacity-7 = 
ramp-capacity-8 = 
ramp-capacity-9 = 
ramp-capacity-foreground = $${colors.foreground-alt}

animation-charging-0 = 
animation-charging-1 = 
animation-charging-2 = 
animation-charging-foreground = $${colors.foreground-alt}
animation-charging-framerate = 750

; animation-discharging-0 = 
; animation-discharging-1 = 
; animation-discharging-2 = 
; animation-discharging-foreground = $${colors.foreground-alt}
; animation-discharging-framerate = 750

[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 60

format = <ramp> <label>
format-underline = $${xrdb:color1}
format-warn = <ramp> <label-warn>
format-warn-underline = $${self.format-underline}

label = %temperature-c%
label-warn = %temperature-c%
label-warn-foreground = $${colors.secondary}

ramp-0 = ﰕ 
ramp-1 = 滛
ramp-2 =  
ramp-foreground = $${colors.foreground-alt}

[module/powermenu]
type = custom/menu

expand-right = true

format-spacing = 1
format-x-offset = -300

label-open = 拉
label-open-foreground = $${colors.secondary}
label-close =ﰸ cancel
label-close-foreground = $${colors.secondary}
label-separator = |
label-separator-foreground = $${colors.foreground-alt}

menu-0-0 = ﰇ reboot
menu-0-0-exec = #powemenu.open.1
menu-0-1 = 襤power off
menu-0-1-exec = #powemenu.open.2

menu-1-0 =ﰸ cancel
menu-1-0-exec = #powermenu.open.0
menu-1-1 = ﰇ reboot
menu-1-1-exec = doas reboot

menu-2-0 = 襤power off
menu-2-0-exec = doas poweroff
menu-2-1 = ﰸ cancel
menu-2-1-exec = #powermenu.open.0

[settings]
screenchange-reload = true
;compositing-background = xor
;compositing-background = screen
;compositing-foreground = source
;compositing-border = over
;pseudo-transparency = false

[global/wm]
margin-top = 5
margin-bottom = 5

; vim:ft=dosini
    '';

in {
  
  services.polybar = {
    enable = false;
    package = myPolybar;
    config = polybarConfig;
    script = ''polybar main &'';
  };
}
