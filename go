#!/bin/bash

# Go vars
export GO15VENDOREXPERIMENT=1
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
alias godocx="godoc -http :6060"
alias check="gometalinter -D gotype"

code() {
	case $1 in
		"check")  cmd="gometalinter -D gotype"; ;;
		"import") cmd="goimports -w"; ;;
                *)        printf  "\033[0;31merror: \033[0mundefined command $1\n"; ;;

	esac
	for dir in $(find -type d); do 
		echo $cmd $dir	
		$cmd $dir; 
	done;
}
