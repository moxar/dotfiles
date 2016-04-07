#!/bin/bash

apt-get update

cat install.txt | {
	while read line
	do
		soft="$soft $line"	
	done
	echo "apt-get install $soft -y"
	apt-get install $soft -y
}

for file in $(ls *.sh | grep -v "install.sh"); do
	source $file
done
