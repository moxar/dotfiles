#!/bin/bash

prefix=$1
line=". $(pwd)/main"

if [ $(grep "$line" ~/.bashrc | wc -l) == 1 ]; then 
	echo "dotfiles already imported";
else
	echo "importing dotfiles";
	echo "export prefix=${prefix}" >> ~/.bashrc;
	echo ". $(pwd)/main" >> ~/.bashrc;
fi
