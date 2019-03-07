rm -rf ~/.vim

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#configs
cp -r ../config/.vim* ~/
wget -P ~/.vim/colors https://raw.githubusercontent.com/caksoylar/vim-mysticaltutor/master/colors/mysticaltutor.vim
cp -r ../config/.git* ~/
cp ../config/gre ~/


# tilix conf
dconf load /com/gexperts/Tilix/ < tilix.dconf

#tmux conf
cp ../config/.tmux.conf ~/


# some keyboard shortcuts
#python3 keycomb.py 'Explorer' 'nautilus' '<Super>E'
#python3 keycomb.py 'tilix' 'tilix --quake' 'F3'

#gnome extensions
mkdir -p ~/.local/share/gnome-shell/extensions


# alt-tab
rm -rf ~/.local/share/gnome-shell/extensions/*
git clone https://github.com/kwalo/gnome-shell-alt-tab-workspace.git ~/.local/share/gnome-shell/extensions/temp #~/git_projects
mv  ~/.local/share/gnome-shell/extensions/temp/*  ~/.local/share/gnome-shell/extensions/
rm -rf ~/.local/share/gnome-shell/extensions/temp
gnome-shell-extension-tool --enable-extension=alt-tab-workspace@kwalo.net

# sys-mon
git clone https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git ~/.local/share/gnome-shell/extensions/temp #~/git_projects
mv ~/.local/share/gnome-shell/extensions/temp/* ~/.local/share/gnome-shell/extensions/
rm -rf ~/.local/share/gnome-shell/extensions/temp
gnome-shell-extension-tool --enable-extension=system-monitor@paradoxxx.zero.gmail.com

# workspace switcher disable
rm -rf ~/.local/share/gnome-shell/extensions/disable-workspace-switcher-popup@github.com
git clone https://github.com/windsorschmidt/disable-workspace-switcher-popup.git \
~/.local/share/gnome-shell/extensions/disable-workspace-switcher-popup@github.com


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
