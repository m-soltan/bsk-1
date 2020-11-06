#!/usr/bin/bash

if [[ $# != 1 ]]; then
	echo "użycie: $0 pracownik"
	exit
fi

for i in $(grep "lokata" -lR zadania/$1 | xargs -L 1 basename); do
	timestamp=$(date +%s)
	printf "zrobione" > lokaty/${1}_${timestamp}.txt
done

for i in $(grep "kredyt" -lR zadania/$1 | xargs -L 1 basename); do
	timestamp=$(date +%s)
	printf "zrobione" > kredyty/${i}_${timestamp}.txt
done
