#!/usr/bin/bash

plik=$1

if [[ $# != 1 ]]; then
	echo "użycie: $0 plik"
	exit
fi

cd zadania
index=5
for i in $(cat $plik); do
	if [[ $index == 4 ]]; then
		printf "kredyt" > $i/z1.txt
		printf "lokata" > $i/z2.txt
	fi
	(( ++index ))
done
