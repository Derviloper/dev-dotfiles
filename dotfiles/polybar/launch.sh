#!/usr/bin/env bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.1; done

polybar --config="$HOME/.config/polybar/config.ini" main &
