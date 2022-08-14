rm -rf ~/.vim

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#configs
cp -r ../config/.vim* ~/
mkdir -p ~/.vim/colors; cd ~/.vim/colors/; wget https://raw.githubusercontent.com/caksoylar/vim-mysticaltutor/master/colors/mysticaltutor.vim
cd ~/

cp -r ../config/.git* ~/

#tmux conf
cp ../config/.tmux.conf ~/

# sshrc config
cp ../config/.sshrc ~/

# vim plugins
wget -O ~/.vim/colors/ https://raw.githubusercontent.com/caksoylar/vim-mysticaltutor/master/colors/mysticaltutor.vim
vim +PluginInstall +qall

# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# zshrc config
cp ../config/.zshrc ~/
cp ../config/mark.zsh-theme ~/.oh-my-zsh/themes/

sudo chsh -s /bin/zsh $(whoami)
