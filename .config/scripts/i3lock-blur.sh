#!/bin/sh
icon="$HOME/.config/i3/lock.png"
# create a temp file
img=$(mktemp /tmp/XXXXXXXXXX.png)
import -window root $img 
convert $img -blur 2,5 $img
convert $img $icon -gravity center -composite $img
i3lock -u -i $img
