#!/usr/bin/env bash

# From, CTT
# Change this depending on your battery in /sys/class/power_supply/
battery="BAT0";

has_battery() {
    if [ -d /sys/class/power_supply/$battery ]; then
        return 0;
    fi
    return 1;
}
get_battery_status() {
    charge="$(get_charge)"
    echo ""$icon" "$charge"%"
}

get_charging_status() {
    cat "/sys/class/power_supply/$battery/status"
}

get_charge() {
    cat "/sys/class/power_supply/$battery/capacity"
}

get_datetime() {
    date +"%a %d %b %Y | %I:%M %p %Z"
}

get_status() {
    battery_status="";
    if $(has_battery); then
        battery_status=" $(get_battery_status) |";
    fi

    echo "${battery_status} $(get_datetime)";
}




# From Reddit 

print_power() {
    status="$(cat /sys/class/power_supply/ADP1/online)"
    battery="$(cat /sys/class/power_supply/BAT1/capacity)"
    timer="$(acpi -b | grep "Battery" | awk '{print $5}' | cut -c 1-5)"
    if [ "${status}" == 1 ]; then
        echo -ne "^c#EBCB8B^󰂄 ^d^${battery}%"
    else
        echo -ne "^c#EBCB8B^󰂁 ^d^${battery}%"
    fi
}

print_backlight() {
    bl="$(xbacklight | sed 's/\..*//')"
    echo -ne "^c#81A1C1^󰃠 ^d^${bl}%"
}

print_wifi() {
    wifissid="$(nmcli -t -f NAME connection show --active | sed 1q)"
    wifiperc="$(grep "^\s*w" /proc/net/wireless | awk '{ print int($3 * 100 / 70) "%" }')"
    echo -ne "^c#B48EAD^󰲝 ^d^${wifiperc} ${wifissid}"
}

print_volume() {
    mix="$(pamixer --get-volume)"
    if [ $mix == 0 ]; then
        echo -ne "^c#8FBCBB^󰖁 ^d^Muted"
    elif [ $mix > 0 ]; then
        echo -ne "^c#88C0D0^󰕾 ^d^${mix}%"
    fi
}

print_date() {
    date="$(LC_ALL=C date "+%a %d %b")"
    echo -ne "^c#BF616A^ ^d^${date}"
}

print_time() {
    time="$(date "+%I:%M %p")"
    echo -ne "^c#A3BE8C^󰥔 ^d^${time}"
}

print_spotify() {
    if ! pgrep -x spotify >/dev/null; then
        echo ""; exit
    fi

    cmd="org.freedesktop.DBus.Properties.Get"
    domain="org.mpris.MediaPlayer2"
    path="/org/mpris/MediaPlayer2"

    meta=$(dbus-send --print-reply --dest=${domain}.spotify \
        /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:${domain}.Player string:Metadata)

    artist=$(echo "$meta" | sed -nr '/xesam:artist"/,+2s/^ +string "(.*)"$/\1/p' | tail -1  | sed "s/\&/+/g")
    album=$(echo "$meta" | sed -nr '/xesam:album"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1)
    title=$(echo "$meta" | sed -nr '/xesam:title"/,+2s/^ +variant +string "(.*)"$/\1/p' | tail -1 | sed "s/\&/+/g")

    echo -ne "^c#A3BE8C^ ^d^${*:-%artist% - %title%}" | sed "s/%artist%/$artist/g;s/%title%/$title/g;s/%album%/$album/g"i | sed 's/&/\\&/g'
}

print_wttr() {
	loc="Pune"
	wttr="$(curl -s v2.wttr.in/${loc} | grep -e "Weather" | sed 's/C,.*/C/g; s/+//g; s/.*\[0m.//g; s/.//2' | sed -n 2p)"
	echo -ne "${wttr}"
}

while true; do
    xsetroot -name " $(print_spotify)  $(print_wifi)  $(print_power)  $(print_backlight)  $(print_volume)  $(print_date)  $(print_time) "
    sleep 1
done
