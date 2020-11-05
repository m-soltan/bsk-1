#!/usr/bin/bash

plik=$1

if [[ $# != 1 ]]; then
	echo "użycie: $0 plik"
	exit
fi

cd zadania
index=5
id=0
for i in $(cat $1); do
	if [[ $index == 5 ]]; then
		id=$i
		index=0
	fi
	if [[ $index == 4 ]]; then
		if [[ $i == 'DBB' ]]; then
			cat ${id}/z1.txt >/dev/null
		fi
	fi
	(( ++index ))
done