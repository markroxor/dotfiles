dconf load /com/gexperts/Tilix/ < tilix.dconf

# win10 theme
wget https://raw.githubusercontent.com/bill-mavromatis/gnome-layout-manager/master/layoutmanager.sh
chmod +x layoutmanager.sh

# the fuck
sudo apt update
sudo apt install python3-dev python3-pip
sudo pip3 install thefuck

# komorebi
wget https://github.com/iabem97/komorebi/releases/download/0.9.2/Komorebi.for.64-bit.deb
sudo dpkg -i Komorebi.for.64-bit.deb

# stacer
bash -c "$(wget https://raw.githubusercontent.com/oguzhaninan/Stacer/native/install.sh -O -)"

# nutty
sudo apt-add-repository ppa:bablu-boy/nutty.0.1 
sudo apt-get update
sudo apt-get install nutty
