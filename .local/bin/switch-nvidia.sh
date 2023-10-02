#!/bin/sh
sudo cp /home/akio/.config/xorg/nvidia-only.conf /etc/X11/xorg.conf.d/10-current.conf
kill $(pidof dwm)
