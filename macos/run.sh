#!/bin/bash
set -e

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# wget
brew install wget

sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# iterm2
brew install --cask iterm2
cp ../config/com.googlecode.iterm2.plist .

brew install htop
brew install nethogs
brew install ncdu
brew install cowsay
brew install coreutils
brew install --cask alt-tab	

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# change to zsh
chsh -s /bin/zsh
