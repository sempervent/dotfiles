#!/bin/bash
# start chromium in a fullscreen mode
# old method included for legacy
#chromium --start-maximized $1
#sleep 2
#xdotool key F11
# new method use this one
chromium --app=$1 -start-fullscreen
