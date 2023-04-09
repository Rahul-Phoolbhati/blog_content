#!/bin/bash

x=1

while read -r line; do 
	echo "Line $x $line"
	((x++))
	sleep 1
	read var
done <  eldenring.sh

