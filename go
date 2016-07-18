#!/bin/bash

# Go vars
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
alias godocx="godoc -http :6060"
alias check="gometalinter -D gotype -D dupl -D aligncheck -D structcheck -D unconvert"

code() {
	case $1 in
		"check")  cmd="gometalinter -D gotype -D dupl -D aligncheck -D structcheck -D unconvert --cyclo-over 15"; ;;
		"lint")  cmd="golint"; ;;
		"vet")  cmd="go vet"; ;;
		"import") cmd="goimports -w"; ;;
                *)        printf  "\033[0;31merror: \033[0mundefined command $1\n"; ;;

	esac
	for dir in $(find -type d); do 
		echo $cmd $dir	
		$cmd $dir; 
	done;
}
