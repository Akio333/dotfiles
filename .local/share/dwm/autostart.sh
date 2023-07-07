feh --bg-fill $HOME/Pictures/wallpapers/wallpaper.png &
picom --config $HOME/.config/picom/picom.conf -b
/usr/bin/lxpolkit &
$HOME/.config/scripts/dwm-status.sh &
xautolock -time 10 -locker i3lock-fancy -nowlocker i3lock-fancy &
nm-applet &
flameshot &
