#!/usr/bin/bash

if [[ $# != 1 ]]; then
	echo "użycie: $0 plik"
	exit
fi

# znowu znajdujemy dyrektorów
biz_dyrektor=""
det_dyrektor=""
index=0
w=()
for i in $(cat $1); do
	k=$(echo $(( $index % 5 )) )
	w[$k]=$i
	if (( $k == 4 )); then
		if [[ ${w[3]} == "dyrektor" ]]; then
			# dyrektor
			nazwa="gfbank${w[0]}dyr"
			gecos=$(echo "${w[1]} ${w[2]}")
			if [[ ${w[4]} == "DBB" ]]; then
				biz_dyrektor=$nazwa
			else
				det_dyrektor=$nazwa
			fi
		fi
	fi
	(( ++index ))
done

# podpunkty a-d
su -c "bash testy/a.sh ../${1}" $det_dyrektor >/dev/null 2>/dev/null
echo "a: ${?}"
su -c "bash testy/b.sh ../${1}" $biz_dyrektor >/dev/null 2>/dev/null
echo "b: ${?}"
su -c "bash testy/c.sh ../${1}" $det_dyrektor >/dev/null 2>/dev/null
echo "c: ${?}"
su -c "bash testy/d.sh ../${1}" $biz_dyrektor >/dev/null 2>/dev/null
echo "d: ${?}"

# podpunkt e
index=5
pracownik=""
for i in $(cat $1); do
	if [[ $index == 5 ]]; then
		pracownik=$i
		index=0
	fi
	if [[ $index == 3 ]]; then
		if [[ $i == "obsługa" ]]; then
			su -c "bash testy/e.sh ${pracownik}" "gfbank${pracownik}obs" >/dev/null 2>/dev/null
			echo "e: ${?}"
		fi
	fi
	(( ++index ))
done

# podpunkt f
index=5
pracownik=""
for i in $(cat $1); do
	if [[ $index == 5 ]]; then
		pracownik=$i
		index=0
	fi
	if [[ $index == 3 ]]; then
		if [[ $i == "obsługa" ]]; then
			su -c "bash testy/f.sh ${pracownik}" "gfbank${pracownik}obs" >/dev/null 2>/dev/null
			echo "f: ${?}"
		fi
	fi
	(( ++index ))
done

# podpunkt g
index=5
pracownik=""
for i in $(cat $1); do
	if [[ $index == 5 ]]; then
		pracownik=$i
		index=0
	fi
	if [[ $index == 3 ]]; then
		if [[ $i == "obsługa" ]]; then
			su -c "bash testy/g.sh" "gfbank${pracownik}obs" >/dev/null 2>/dev/null
			echo "g: ${?}"
		fi
	fi
	(( ++index ))
done
