#!/bin/bash

mkdir ~/.bin
mkdir -p $HOME/.config

touch $HOME/.config/$USER
ln -s $(pwd)/config/nvim $HOME/.config/nvim
ln -s $(pwd)/config/plasma-workspace $HOME/.config/plasma-workspace
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/gitignore $HOME/.gitignore
