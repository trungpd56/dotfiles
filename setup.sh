#!/bin/bash
dotfilesDir=$(pwd)

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink
    echo "Removing existing symlink: ${dest}"
    rm ${dest}

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

linkDotfile .vim
linkDotfile .inputrc
linkDotfile .curlrc
linkDotfile .tmux.conf
linkDotfile .gitconfig

sudo apt -y install tmux tree rename curl git
grep 'myalias' ~/.bashrc || echo 'source ~/dotfiles/myalias' >> ~/.bashrc
source ~/.bashrc
curl -sL install-node.vercel.app/lts | sudo bash

# curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
# grep 'zoxide' ~/.bashrc || echo 'eval "$(zoxide init bash --cmd cd)"' >> ~/.bashrc
# cd /tmp && wget https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb && dpkg -i git-delta_0.17.0_amd64.deb
# sudo add-apt-repository ppa:jonathonf/vim
