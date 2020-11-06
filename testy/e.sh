#!/usr/bin/bash

if [[ $# != 1 ]]; then
	echo "użycie: $0 pracownik"
	exit
fi

cd zadania
cd $1
for i in $(ls); do
	cat $i > /dev/null
done

for i in $(ls); do
	printf "zrobione" >> $i
done;
