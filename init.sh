#!/bin/bash

prefix=$1

if [ "$prefix" == "" ]; then
    printf  "\033[0;31merror: \033[0mnot enough argument. define computer name\n"
    exit 1
fi

line=". $(pwd)/main"

if [ $(grep "$line" ~/.bashrc | wc -l) == 1 ]; then 
	echo "dotfiles already imported";
else
	echo "importing dotfiles";
	echo "export prefix=${prefix}" >> ~/.bashrc;
	echo ". $(pwd)/main" >> ~/.bashrc;
fi
