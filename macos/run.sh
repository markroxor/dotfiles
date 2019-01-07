#!/bin/bash
set -e

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# wget
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# iterm2
brew cask install iterm2
cp ./config/com.googlecode.iterm2.plist .

rm -rf ~/.vim

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# vim config
cp -r config/.vim* ~/

# sshrc config
cp ./config/.sshrc ~/

# vim plugins
vim +PluginInstall +qall

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# zshrc config
cp ./config/.zshrc ~/
cp mark.zsh-theme ~/.oh-my-zsh/themes/

# change to zsh
chsh -s /bin/zsh
