indentifier="usb-Sennheiser"
index=$(pacmd list-cards |awk '/index:/ {print $0} /name:/ {print $0};' | grep -B1 $indentifier | head -n1 | cut -d ":" -f 2)
echo $index
if [[ $1 = 'r' ]]
    then
        pacmd set-card-profile $index output:analog-stereo
elif [[ $1 = 'mic' ]]
    then
        pacmd set-card-profile $index input:multichannel-input
else
    echo "no"
fi

# bluetooth
indentifier="00_1B_66"
index=$(pacmd list-cards |awk '/index:/ {print $0} /name:/ {print $0};' | grep -B1 $identifier | head -n1 | cut -d ":" -f 2)
echo $index
if [[ $1 = 'r' ]]
    then
        pacmd set-card-profile $index headset_head_unit && sleep 1 && pacmd set-card-profile $index a2dp_sink
        index_=$(pacmd list-sinks |awk '/index:/ {print $0} /name:/ {print $0};' | grep -B1 "00_1B_66" | head -n1 | cut -d ":" -f 2)
        pacmd set-sink-mute $index_ 0
elif [[ $1 = 'mic' ]]
    then
        pacmd set-card-profile $index headset_head_unit && pacmd set-sink-mute $index_ 1
        index_=$(pacmd list-sinks |awk '/index:/ {print $0} /name:/ {print $0};' | grep -B1 "00_1B_66" | head -n1 | cut -d ":" -f 2)
        # pacmd set-sink-mute $index_ 1

else
    echo "no"
fi
