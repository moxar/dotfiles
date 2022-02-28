#!/bin/bash

mkdir ~/.bin
mkdir -p $HOME/.config

curl -o ~/.bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/.bin/*

ln -s $(pwd)/config/nvim $HOME/.config/nvim
ln -s $(pwd)/config/plasma-workspace $HOME/.config/plasma-workspace
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/gitignore $HOME/.gitignore
