#!/bin/bash
set -e

#
# && echo "    ...backed up"
#  else
#    rm -rf "$ORIG"
#    echo "    ...deleted"
#  fi
#  ln -s "$NEW" "$ORIG" && echo "    ...linked"
#}

#if [[ $# == 1 ]]; then
#  [[ $1 =~ '-y' ]] && BACKUP='y'
#  [[ $1 =~ '-n' ]] && BACKUP='n'
#else
#  read -p "Backup files? (y/n) " -n 1; echo
#  BACKUP=$REPLY
#fi

#cd "$(dirname "${BASH_SOURCE}")"

#echo "Symlinking..."

#for DOTFILE in $(find . -maxdepth 1 -name '.?*'); do
#  [[ $DOTFILE != "./.git" ]] \
#    && [[ $DOTFILE != "./.gitmodules" ]] \
#    && [[ $DOTFILE != "./.gitignore" ]] \
#    && [[ $DOTFILE != "./.config" ]] \
#    && [[ $DOTFILE != "./screenshots" ]] \
#    && [[ ! $DOTFILE =~ swp$ ]] \
#    && link_file "$HOME/$DOTFILE" "$PWD/$DOTFILE"
#done

#mkdir -p $HOME/.config
#cd .config
#for DOTFILE in $(find . -maxdepth 1 ! -path .); do
#  link_file "$HOME/.config/$DOTFILE" "$PWD/$DOTFILE"
#done


# tilix
add-apt-repository -y ppa:oguzhaninan/stacer
add-apt-repository -y ppa:webupd8team/terminix
add-apt-repository -y ppa:yktooo/ppa
add-apt-repository -y ppa:bablu-boy/nutty.0.1
apt-get update


#git
apt-get -y install git
apt-get -y install curl

#vim
apt-get -y install vim

# gre
apt-get -y install cowsay

# tilix
apt-get install -y tilix


# windows theme
#./layoutmanager.sh --windows


#system monitor
apt-get -y install gir1.2-gtop-2.0 gir1.2-nm-1.0  gir1.2-clutter-1.0

#sound indicator
apt-get -y install indicator-sound-switcher

# zshrc
apt-get install -y zsh

# sshrc
wget https://raw.githubusercontent.com/Russell91/sshrc/master/sshrc 
chmod +x sshrc
mv sshrc /usr/local/bin #or anywhere else on your PATH

# Stacer
apt-get -y install stacer

# nutty
apt-get -y install nutty

# xdm
wget https://excellmedia.dl.sourceforge.net/project/xdman/xdm-2018-x64.tar.xz -P ~/Downloads
tar -xvf ~/Downloads/xdm-2018-x64.tar.xz
~/Downloads/xdm.sh

# ncdu
apt-get install ncdu -y

# python pygments
apt install python-pygments
