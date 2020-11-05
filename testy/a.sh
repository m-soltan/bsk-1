#!/usr/bin/bash

plik=$1

if [[ $# != 1 ]]; then
	echo "użycie: $0 plik"
	exit
fi

cd zadania
index=5
pracownik=""
for i in $(cat $plik); do
	if [[ $index == 5 ]]; then
		pracownik=$i
		index=0
	fi
	if [[ $index == 4 ]]; then
		if [[ $i == 'DBD' ]]; then
			printf "kredyt" > ${pracownik}/z1.txt
			printf "lokata" > ${pracownik}/z2.txt
		fi
	fi
	(( ++index ))
done
