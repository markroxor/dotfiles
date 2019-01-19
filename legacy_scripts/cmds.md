### disabling kworkers
grep . -r /sys/firmware/acpi/interrupts/
echo "disable" > /sys/firmware/acpi/interrupts/gpe17

### list voluntarily installed packages
(zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) 2>/dev/null |
  egrep '^(Start-Date:|Commandline:)' |
  grep -v aptdaemon |
  egrep '^Commandline:'

### sorts tracker bug
echo -e "\nHidden=true\n" | sudo tee --append /etc/xdg/autostart/tracker-extract.desktop /etc/xdg/autostart/tracker-miner-apps.desktop /etc/xdg/autostart/tracker-miner-fs.desktop /etc/xdg/autostart/tracker-miner-user-guides.desktop /etc/xdg/autostart/tracker-store.desktop > /dev/null
gsettings set org.freedesktop.Tracker.Miner.Files crawling-interval -2  
gsettings set org.freedesktop.Tracker.Miner.Files enable-monitors false  
tracker reset --hard

### Run jupyter notebooks remotely
ssh -nNT -L 9999:localhost:8888 markroxor@192.168.1.163


### create jupyter kernel
python -m ipykernel install --user --name venv_fs2ml --display-name "fs2ml2"
vim ~/.local/share/jupyter/kernels/env/kernel.json

## Remove dangling images
docker rmi $(sudo docker images --filter "dangling=true" -q --no-trunc)
docker system prune
