#!/bin/bash

line=". $(pwd)/main"
echo $line >> ~/.bashrc;

cp $(pwd)/vimrc ~/.vimrc
cp $(pwd)/gitconfig ~/.gitconfig
cp $(pwd)/gitignore ~/.gitignore
