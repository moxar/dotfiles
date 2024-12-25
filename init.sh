#!/bin/bash

mkdir -p $HOME/.config

touch $HOME/.config/$USER
ln -s $(pwd)/config/plasma-workspace $HOME/.config/plasma-workspace
ln -s $(pwd)/helix $HOME/.config/helix
ln -s $(pwd)/tmate $HOME/.config/tmate
ln -s $(pwd)/tmux $HOME/.config/tmux
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/gitignore $HOME/.gitignore
