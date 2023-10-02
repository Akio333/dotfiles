loc="Pune"
wttr="$(curl -s v2.wttr.in/${loc} | grep -e "Weather" | sed 's/C,.*/C/g; s/+//g; s/.*\[0m.//g; s/.//2' | sed -n 2p)"
echo -ne "${wttr}"

