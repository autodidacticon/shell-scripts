#!/bin/bash
HOSTNAME=`hostname`
HOSTNAME=${1:-$HOSTNAME}
sudo hostname -s $HOSTNAME
cd ~
mkdir git
cd git
#install Xcode CLT
xcode-select --install

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install 'brew bundle'
brew update
git config --global hub.protocol https
hub clone autodidacticon/dotfiles

# install stuff
cd ~/git/dotfiles/host-$HOSTNAME
brew bundle -v

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#get dotfiles
rcup -d $HOME/git/dotfiles -B `hostname -s` -x README.md
