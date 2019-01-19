rm -rf ~/.vim

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#configs
cp -r ../config/.vim* ~/
cp -r ../config/.git* ~/
cp ../config/gre ~/

# zshrc config
cp ../config/.zshrc ~/
cp ../config/mark.zsh-theme ~/.oh-my-zsh/themes/

# sshrc config
cp ../config/.sshrc ~/

# vim plugins
vim +PluginInstall +qall

