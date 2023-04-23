#!/bin/bash

read -p "Enter the city name: " city

while [[ $city != "exit" ]];
do 
	weather=$(curl -s http://wttr.in/$city?format=3)
	echo "The weather for $weather"
	read -p "Enter the city name: " city
done
