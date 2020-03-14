#!/bin/bash

mkdir ~/.bin
curl -o ~/.bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/.bin/*

git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/jparise/vim-graphql.git ~/.vim/pack/plugins/start/vim-graphql
ln -s $HOME/.dotfiles/vimrc $HOME/.vimrc

line=". $(pwd)/main"
echo $line >> ~/.bashrc;

cp $(pwd)/vimrc ~/.vimrc
cp $(pwd)/gitconfig ~/.gitconfig
cp $(pwd)/gitignore ~/.gitignore
