bspwm:
	watchexec -w modules/home-manager/bspwm -- bspc wm -r

eww:
	watchexec -w modules/home-manager/eww -- eww reload

sxhkd:
	watchexec -w modules/home-manager/sxhkd -- pkill -USR1 -x sxhkd
