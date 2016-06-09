#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
urxvtd -q -o -f &

# udiskie - removable disk automounter for udisks
udiskie &

# Select Window Manager at SLiM prompt using 'F1'
#exec $1

# exec gnome-session
# exec startkde
# exec startxfce4
exec i3
# ...or the Window Manager of your choice
#if [[ $1 == "xfce" ]]; then
#	exec startxfce4
#elif [[ $1 == "i3" ]]; then
#	exec i3
#else
#	echo "Choose a window manager"
#fi
