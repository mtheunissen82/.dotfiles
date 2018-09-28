#!/usr/bin/env bash

# Install apt packages
sudo apt-get install -y vim nvim curl wget git silversearcher-ag tmux

# Install nvm (node version manager)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install latest stable nodejs
nvm install --lts

# Install global npm modules
npm install -g diff-so-fancy
npm install -g @angular/cli

# Install vim plugins
vim +'PlugInstall --sync' +qa

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Replace config files/directories with customized version from .dotfiles
if [[ -f ~/.bashrc && ! -L ~/.bashrc ]]; then
    mv ~/.bashrc ~/.bashrc.old
    ln -s ~/.dotfiles/.bashrc ~/.bashrc
fi

if [[ -f ~/.gitconfig && ! -L ~/.gitconfig ]]; then
    mv ~/.gitconfig ~/.gitconfig.old
    ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
fi

if [[ -d ~/.vim && ! -L ~/.vim ]]; then
    mv ~/.vim ~/.vim.old
    ln -s ~/.dotfiles/.vim ~/.vim
fi

if [[ -f ~/.vimrc && ! -L ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.old
    ln -s ~/.dotfiles/.vim/vimrc ~/.vimrc
fi

if [[ -f ~/.tmux.conf && ! -L ~/.tmux.conf ]]; then
    mv ~/.tmux.conf ~/.tmux.conf.old
    ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
fi

if [[ -d ~/.tmux && ! -L ~/.tmux ]]; then
    mv ~/.tmux ~/.tmux.old
    ln -s ~/.dotfiles/.tmux ~/.tmux
fi


mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

# Enable tmux on startup (see .bashrc)
touch ~/.tmux_on_startup

# Enable git completion
sudo curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -L -o /etc/bash_completion.d/git-completion.bash
