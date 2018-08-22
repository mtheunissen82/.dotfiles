#!/usr/bin/env bash

if [[ -f ~/.bashrc ]]; then
    mv ~/.bashrc ~/.bashrc.old
fi

if [[ -f ~/.gitconfig ]]; then
    mv ~/.gitconfig ~/.gitconfig.old
fi

if [[ -d ~/.vim ]]; then
    mv ~/.vim ~/.vim.old
fi

if [[ -f ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.old
fi

if [[ -f ~/.tmux.conf ]]; then
    mv ~/.tmux.conf ~/.tmux.conf.old
fi

if [[ -d ~/.tmux ]]; then
    mv ~/.tmux ~/.tmux.old
fi

ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.vim ~/.vim
ln -s ~/.dotfiles/.vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.tmux ~/.tmux

mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
