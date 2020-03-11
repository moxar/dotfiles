#!/bin/bash

mkdir ~/.bin
curl -o ~/.bin/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/.bin/diff-so-fancy

line=". $(pwd)/main"
echo $line >> ~/.bashrc;

cp $(pwd)/vimrc ~/.vimrc
cp $(pwd)/gitconfig ~/.gitconfig
cp $(pwd)/gitignore ~/.gitignore
