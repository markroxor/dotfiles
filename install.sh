#!/bin/bash
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




#git
sudo apt-get -y install git
sudo apt-get -y install curl
sudo apt-get -y install python-pigments
cp -r config/.git* ~/

#vim configs
#vim
sudo apt-get -y install vim

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#configs
cp -r config/.vim* ~/



# gre
sudo apt-get -y install cowsay
cp gre ~/

# tilix
sudo add-apt-repository -y ppa:webupd8team/terminix
sudo apt-get update
sudo apt-get install -y tilix

# tilix conf
dconf load /com/gexperts/Tilix/ < tilix.dconf

# googler
sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v3.3/googler && sudo chmod +x /usr/local/bin/googler


#tmux conf
cp ./config/.tmux.conf ~/


# windows theme
#./layoutmanager.sh --windows

# some keyboard shortcuts
python3 keycomb.py 'Explorer' 'nautilus' '<Super>E'
python3 keycomb.py 'tilix' 'tilix --quake' 'F3'


#gnome extensions
#system monitor
sudo apt-get -y install gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0
mkdir ~/git_projects
cd ~/git_projects
git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
mkdir -p ~/.local/share/gnome-shell/extensions
cd ~/.local/share/gnome-shell/extensions
ln -s ~/git_projects/gnome-shell-system-monitor-applet/system-monitor@paradoxxx.zero.gmail.com
gnome-shell-extension-tool --enable-extension=system-monitor@paradoxxx.zero.gmail.com

#sound indicator
sudo apt-add-repository -y ppa:yktooo/ppa
sudo apt-get update
sudo apt-get -y install indicator-sound-switcher

#workspace switcher disable
mkdir -p ~/.local/share/gnome-shell/extensions 2>/dev/null
git clone git://github.com/windsorschmidt/disable-workspace-switcher-popup \
~/.local/share/gnome-shell/extensions/disable-workspace-switcher-popup@github.com


# zshrc
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh

# zshrc config
cp ./config/.zshrc ~/
cp mark.zsh-theme ~/.oh-my-zsh/themes/


# Stacer
sudo add-apt-repository -y ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get -y install stacer

# komorebi desktop
wget https://github.com/iabem97/komorebi/releases/download/v2.0/komorebi-2-64-bit.deb

# nutty
sudo apt-add-repository -y ppa:bablu-boy/nutty.0.1
sudo apt-get update
sudo apt-get -y install nutty

# xdm
wget https://excellmedia.dl.sourceforge.net/project/xdman/xdm-2018-x64.tar.xz -P ~/Downloads
tar -xvf ~/Downloads/xdm-2018-x64.tar.xz
sudo ~/Downloads/install.sh

# ncdu
sudo apt-get install ncdu -y
