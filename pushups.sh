#!/bin/bash

x=1

while [[ $x -le 5 ]]
do
	read -p "Pushup $x: Press enter to continue"
	(( x ++ ))
done
echo "You did it"
