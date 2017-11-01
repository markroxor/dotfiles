#!/bin/bash
#
# install.sh
# Symlink all dotfiles in this repo to $HOME.
#
# Originally by Brandon Amos
# changes by Mohit Rathore(markroxor)

#to stop the execution of the script totally if an error is encountered
set -e

link_file() {
  local ORIG="$1"; local NEW="$2"

  echo "  '$ORIG'"
  if [[ $BACKUP =~ ^[Yy]$ ]]; then
    mv "$ORIG" "${ORIG}.bak" &> /dev/null \
    && echo "    ...backed up"
  else
    rm -rf "$ORIG"
    echo "    ...deleted"
  fi
  ln -s "$NEW" "$ORIG" && echo "    ...linked"
}

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

# gre
sudo apt-get install cowsay
cp gre ~/

# git
sudo apt-get install git

# tilix
sudo add-apt-repository ppa:webupd8team/terminix
sudo apt-get update
sudo apt-get install tilix

# tilix conf
dconf load /com/gexperts/Tilix/ < tilix.dconf

# googler
sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v3.3/googler && sudo chmod +x /usr/local/bin/googler

# vim
cp .vim* ~/

# zshrc
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# nerdTree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# zshrc config
cp .zshrc ~/
cp mark.zsh-theme ~/.oh-my-zsh/themes/

# windows theme
./layoutmanager.sh --windows

# some keyboard shortcuts
python3 keycomb.py 'Explorer' 'nautilus' '<Super>E'
python3 keycomb.py 'tilix' 'tilix --quake' 'F3'
