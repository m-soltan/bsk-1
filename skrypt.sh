#!/usr/bin/bash

# działy: DBB, DBD
# grupy: biz_employee, det_employee, biz_director, det_director

# prawa grup:
#    biz_emp - 
# odczyt: dla biz_director, det_director

# 2 listy
#  - dla kredytów i lokat
#user: det_dir
#  - dla zadań

FILE=$1
BIZ_GR="DBB"
DET_GR="DBD"

index=0
w=()
biz_dyrektor=""
det_dyrektor=""

if [[ $# != 1 ]]; then
	echo "usage: $0 input_file"
	exit 1
fi

# tworzymy grupy
adduser --force-badname --group $BIZ_GR
adduser --force-badname --group $DET_GR


mkdir kredyty
chmod a+rwxt kredyty

mkdir lokaty
chmod a+rwxt lokaty

mkdir zadania

# bierzemy wszystko co potrzebne z pliku wejściowego
for i in $(cat $FILE); do
	k=$(echo $(( $index % 5 )) )
	w[$k]=$i
	if (( $k == 4 )); then
		nazwa=""
		gecos=$(echo "${w[1]} ${w[2]}")
		if [[ ${w[3]} == "dyrektor" ]]; then
			# dyrektor
			nazwa="gfbank${w[0]}dyr"
			adduser --disabled-password --gecos "${gecos}" $nazwa
			if [[ ${w[4]} == $BIZ_GR ]]; then
				biz_dyrektor=$nazwa
			else
				det_dyrektor=$nazwa
			fi
		else
			# obsługa
			nazwa="gfbank${w[0]}obs"
			# katalog członka obsługi
			katalog=zadania/${w[0]}
			mkdir $katalog
			chmod go-rwx $katalog
			adduser --disabled-password --gecos "${gecos}" $nazwa
			setfacl -m user:$nazwa:rx $katalog
		fi
		
		# ustawienia grup użytkownika
		usermod -a -G ${w[4]} $nazwa
		usermod -g ${w[4]} $nazwa
	fi
	(( ++index ))
done

arr1=("kredyty" "lokaty")
for i in $arr1; do
	setfacl -d -m other:- $i
	setfacl -d -m user:${det_dyrektor}:rx $i
	setfacl -d -m user:${biz_dyrektor}:rx $i

	setfacl -d -m group::r $i
	setfacl -d -m user::rw $i
done
