mix="$(pamixer --get-volume)"
if [ $mix == 0 ]; then
    echo -ne "^c#8FBCBB^󰖁 ^d^Muted"
elif [ $mix > 0 ]; then
    echo -ne "^c#88C0D0^󰕾 ^d^${mix}%"
fi

