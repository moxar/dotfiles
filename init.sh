#!/bin/bash

line=". $(pwd)/main"
. $(pwd)/colors

if [ $(grep "$line" ~/.bashrc | wc -l) == 1 ]; then 
	echo "${GREEN}dotfiles already imported";
else
	echo "${GREEN}importing dotfiles";
	echo $line >> ~/.bashrc;
fi

if [ $(grep "GOPATH=" ~/.bashrc | wc -l) == 1 ]; then
	echo "${GREEN}GOPATH already set";
else
	read -p "`echo -e ${DEFAULT}'define GOPATH location: \n\b'`" GOPATH
	if [ $(find $GOPATH -type d 2>/dev/null | wc -l) -eq 0 ]; then
		echo "${RED}error: ${DEFAULT}no such file or directory \"$GOPATH\"";
	else
		echo "${GREEN}exporting GOPATH";
	fi
	echo "export GOPATH=$GOPATH" >> ~/.bashrc;
fi
