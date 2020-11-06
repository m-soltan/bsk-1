#!/usr/bin/bash

if [[ $# != 0 ]]; then
	echo "użycie: $0"
	exit
fi

cd kredyty
for i in $(ls); do
	printf "zrobione" >> $i
done

cd ../zadania
for i in $(ls); do
	printf "zrobione" >> $i
done
