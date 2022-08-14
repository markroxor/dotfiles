#!/bin/bash
set -e

sudo yum update
sudo yum update -y
# apt-get install software-properties-common (not needed in yum)

sudo yum install util-linux-user -y
sudo amazon-linux-extras install epel -y
sudo yum install tmux -y

#vim
sudo yum install vim
sudo yum install vim-enhanced -y

# tilix
sudo curl https://copr.fedorainfracloud.org/coprs/ivoarch/Tilix/repo/epel-7/ivoarch-Tilix-epel-7.repo -o /etc/yum.repos.d/tilix.repo
sudo yum update -y
sudo yum install tilix -y

# zshrc
sudo yum install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ncdu finds exact folder size with --h
sudo yum install ncdu -y

# python pygments
sudo yum -y install python-pygments.noarch
