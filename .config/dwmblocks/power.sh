status="$(cat /sys/class/power_supply/ADP1/online)"
battery="$(cat /sys/class/power_supply/BAT1/capacity)"
timer="$(acpi -b | grep "Battery" | awk '{print $5}' | cut -c 1-5)"
if [ "${status}" == 1 ]; then
    echo -ne "^c#EBCB8B^󰂄 ^d^${battery}%"
else
    echo -ne "^c#EBCB8B^󰂁 ^d^${battery}%"
fi

