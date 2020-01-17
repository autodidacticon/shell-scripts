#!/bin/bash
set -e
# install stuff
sudo yum install -y zsh tmux htop jq the_silver_searcher

GITHUB_DOMAIN=github.com
GITHUB_DOMAIN=${1:-$GITHUB_DOMAIN}
GITHUB_USER=autodidacticon
GITHUB_USER=${2:-$GITHUB_USER}

# get the script execution path
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

# ssh keys
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>/dev/null <<< y >/dev/null

# put them to github
. "$DIR/create-key.sh" $GITHUB_DOMAIN $GITHUB_USER

cd ~; mkdir -p git; cd git
rm -rf packages; git clone https://$GITHUB_DOMAIN:$GITHUB_USER/packages
rm -rf dotfiles; git clone https://$GITHUB_DOMAIN:$GITHUB_USER/dotfiles
rm -rf ohmyzsh; git clone https://$GITHUB_DOMAIN:$GITHUB_USER/ohmyzsh

# install rpms
cd packages
# assemble scala
cat scalaa* > scala.rpm
for f in *.rpm; do
    sudo yum localinstall -y $f --nogpgcheck
done

# install hub manually
rm -rf ~/tmp; mkdir ~/tmp; tar -zxf ~/git/packages/hub-linux-amd64-2.13.0.tgz -C ~/tmp; sudo ~/tmp/hub-linux-amd64-2.13.0/install; rm -rf ~/tmp

# install amm manually
sudo mv ~/git/packages/amm /usr/local/bin/amm && chmod +x /usr/local/bin/amm

# install oh-my-zsh
export REPO=$GITHUB_USER/ohmyzsh
export REMOTE=https://$GITHUB_DOMAIN/$GITHUB_USER/ohmyzsh.git
export RUNZSH=yes
cd ~; ./git/ohmyzsh/tools/install.sh --unattended

# hack to get around chsh failures
echo "exec /bin/zsh --login" >> .bash_profile

# install dotfiles
rcup -f -d ~/git/dotfiles -B utility -x README.md
