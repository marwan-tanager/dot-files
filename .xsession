#!/bin/bash

start_xbindkeys()
{
  pid="$(pidof xbindkeys)"
  [ -z "$pid" ] && xbindkeys
}

set_keyboard_speed()
{
  xset r rate 250 60
}

set_touchpad_speed()
{
  synclient MaxSpeed=255
  synclient MinSpeed=1.5
}

enable_clicking_with_touchpad()
{
  # synclient TapButton1=1
  # synclient TapButton2=3
  # synclient TapButton3=2

  xinput --set-prop --type=int --format=8 "DLLC6B2:00 06CB:75BF Touchpad" "Synaptics Tap Action"  0 0 0 1 1 0
}

set_background_wallpaper()
{
  eval "$(cat ~/.fehbg)"
}

disalbe_screen_blanking()
{
  xset s off -dpms
}

redshift &
start_xbindkeys
set_keyboard_speed
disalbe_screen_blanking

# I configure touchpad at /etc/X11/xorg.conf.d/50-synaptics.conf, because this 
# file is read across suspends/resumes, as oppoosed to ~/.xsession which is 
# only read at the start of the session, resulting in this configs being lost 
# after resuming from suspend. I will leave the conifgs commented here, though, 
# just for reference. 
# 
# Note: the values for the MaxSpeed and MinSpeed options appear to be scaled 
# differently at those two files, so adjust appropriately in each one.

set_touchpad_speed
enable_clicking_with_touchpad
/home/marwan/bin/disable-touchpad.sh
# unclutter -idle 2 &
set_background_wallpaper
/usr/bin/xscreensaver -no-splash &
# /usr/bin/skype &
# /usr/bin/skype-call-recorder &
# /usr/bin/dropbox start
/usr/bin/dunst &

# Dump the current $DISPLAY environment variable into a file to be read later 
# by cron (more specifically, the ~/bin/cron_set_background_wallpaper.sh 
# script) when changing the desktop background periodically using feh.

echo "$DISPLAY" >/tmp/cron.DISPLAY

# Allow all users (particularly, 'root') to connect to this X server instance

xhost +

. /home/marwan/.profile
exec /home/marwan/.xmonad/xmonad-x86_64-linux
