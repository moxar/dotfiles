#!/bin/bash

mkdir ~/.bin
curl -o ~/.bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/.bin/*

git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/jparise/vim-graphql.git ~/.vim/pack/plugins/start/vim-graphql

mkdir -p $HOME/.config
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/fish $HOME/.config/fish
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/gitignore $HOME/.gitignore
