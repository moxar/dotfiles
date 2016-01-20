#!/bin/bash

line=". $(pwd)/main"

if [ $(grep "$line" ~/.bashrc | wc -l) == 1 ]; then 
	echo "dotfiles already imported";
else
	echo "importing dotfiles";
	echo ". $(pwd)/main" >> ~/.bashrc;
fi
