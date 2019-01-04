#!/bin/bash
set -e

# add-apt-repository ppa:bablu-boy/nutty.0.1
add-apt-repository ppa:yktooo/ppa

apt-get update

#sound indicator
apt-get -y install indicator-sound-switcher

#git
apt-get -y install git
apt-get -y install curl

#vim
apt-get -y install vim

# gre
apt-get -y install cowsay

# tilix
apt-get install -y tilix

#system monitor
apt-get -y install gir1.2-gtop-2.0 gir1.2-nm-1.0  gir1.2-clutter-1.0

# zshrc
apt-get install -y zsh

# sshrc
wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc
chmod +x sshrc
mv sshrc /usr/local/bin #or anywhere else on your PATH

apt-get install htop -y
apt-get install nethogs -y

# ncdu finds exact folder size with --h
apt-get install ncdu -y

# python pygments
apt install python-pygments
