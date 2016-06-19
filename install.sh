#!/usr/bin/env bash

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#change default shell
chsh -s /bin/zsh
ln -sv “~/.dotfiles/runcom/.bashrc” ~
ln -sv “~/.dotfiles/runcom/.zshrc” ~
ln -sv “~/.dotfiles/git/.gitconfig” ~
ln -sv “~/.dotfiles/git/.gitignore” ~
