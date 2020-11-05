#!/usr/bin/bash

plik=$1
biz_dyrektor=$2
det_dyrektor=$3

if [[ $# != 3 ]]; then
	echo "użycie: $0 plik biz_dyrektor det_dyrektor"
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
