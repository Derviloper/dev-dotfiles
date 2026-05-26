bspwm:
	bspc wm -r

eww:
	eww reload

sxhkd:
	watchexec -w modules/home-manager/sxhkd/sxhkdrc -- pkill -USR1 -x sxhkd
