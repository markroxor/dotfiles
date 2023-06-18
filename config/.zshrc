#!/usr/bin/env bash

export ZSH=~/.oh-my-zsh

ZSH_THEME="mark"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

#########Experimental
#set history size
export HISTSIZE=10000
#save history after logout
export SAVEHIST=10000
#history file
export HISTFILE=~/.zhistory
#append into history file
setopt INC_APPEND_HISTORY
#save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
#add timestamp for each entry
setopt EXTENDED_HISTORY
##########################!/usr/bin/env bash

# disables "somethin" > impFile to "somethin" >| impFile
set -o noclobber

#if [[ $(uname)='Darwin' ]]
#then
#    alias shuf=gshuf
#fi

#shuf -n 1 ~/gre | cowsay

#alias please=sudo
#alias l=ls
#alias cat="pygmentize -g"

export HOMEBREW_NO_AUTO_UPDATE=1
