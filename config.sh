rm -rf ~/.vim

#vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#configs
cp -r config/.vim* ~/
cp -r config/.git* ~/
cp gre ~/


# tilix conf
dconf load /com/gexperts/Tilix/ < tilix.dconf

#tmux conf
cp ./config/.tmux.conf ~/


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
git clone git://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git ~/.local/share/gnome-shell/extensions/temp #~/git_projects
mv ~/.local/share/gnome-shell/extensions/temp/* ~/.local/share/gnome-shell/extensions/
rm -rf ~/.local/share/gnome-shell/extensions/temp
gnome-shell-extension-tool --enable-extension=system-monitor@paradoxxx.zero.gmail.com

#workspace switcher disable
rm -rf ~/.local/share/gnome-shell/extensions/disable-workspace-switcher-popup@github.com
git clone git://github.com/windsorschmidt/disable-workspace-switcher-popup \
~/.local/share/gnome-shell/extensions/disable-workspace-switcher-popup@github.com

# zshrc config
cp ./config/.zshrc ~/
cp mark.zsh-theme ~/.oh-my-zsh/themes/

# sshrc config
cp ./config/.sshrc ~/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
