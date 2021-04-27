# https://askubuntu.com/questions/78174/play-sound-through-two-or-more-outputs-devices#:~:text=6%20Answers&text=Show%20activity%20on%20this%20post.,-With%20paprefs%20you&text=Then%20in%20terminal%20run%20paprefs,on%20all%20local%20sounds%20cards%22.

identifier="usb-Sennheiser"
index=$(pacmd list-cards |awk '/index:/ {print $0} /name:/ {print $0};' | grep -B1 $identifier | head -n1 | cut -d ":" -f 2)
echo $index
if [[ $1 = 'r' ]]
    then
        pacmd set-card-profile $index output:analog-stereo && pacmd set-default-sink combined

elif [[ $1 = 'mic' ]]
    then
        pacmd set-card-profile $index input:multichannel-input
else
    echo "no"
fi

# bluetooth
exit
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


