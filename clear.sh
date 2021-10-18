#!/bin/bash

downloads=/mnt/c/Users/XXX/Downloads
documents=/mnt/c/Users/XXX/Documents

function clear_files(){
	echo $1 > nazwa.txt
	count=$(find $1 -maxdepth 1 -type f | wc -l)
	if [ "$count" -eq 0 ]; then
		echo "Nie ma czego przenosić z $(awk -F '/' '{ print $6 }' nazwa.txt)"

	else 
		echo "Przenoszę $count plików z $(awk -F '/' '{ print $6 }' nazwa.txt)"
		mv "$1"/*.* "$1"/temp
	fi
}

clear_files $downloads
clear_files $documents
rm nazwa.txt
