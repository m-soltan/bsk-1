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
biz_obsluga=()
det_obsluga=()

for i in $(cat $FILE); do
	k=$(echo $(( $index % 5 )) )
	w[$k]=$i
	if (( $k == 4 )); then
		dr="dyrektor"
		
		name=$(echo "${w[1]}_$(echo ${w[2]} | head -c 1)_${w[0]}")
		lowercase=$(echo $name | tr '[:upper:]' '[:lower:]')
		echo $lowercase
		gecos=$(echo "${w[1]} ${w[2]}")
		
		adduser --disabled-password --gecos "${gecos}" "${lowercase}"
		if [[ ${w[3]} == $dr ]]; then
			# dyrektor
			if [[ ${w[4]} == $BIZ_GR ]]; then
				biz_dyrektor=$lowercase
			else
				det_dyrektor=$lowercase
			fi
		else
			# obsługa
			if [[ ${w[4]} == $BIZ_GR ]]; then
				biz_obsluga+=($lowercase)
			else
				det_obsluga+=($lowercase)
			fi
		fi
		usermod -a -G ${w[4]} $lowercase
	fi
	(( ++index ))
done


# tworzymy grupy
adduser --force-badname --group $BIZ_GR
adduser --force-badname --group $DET_GR

mkdir kredyty
chmod a+rwxt kredyty

mkdir lokaty
chmod a+rwxt lokaty

mkdir zadania

arr1=("kredyty" "lokaty")
for i in $arr1; do
	setfacl -d -m other:-rw $i
done
setfacl -d -m user:${biz_dyrektor}:rx kredyty
setfacl -d -m user:${biz_dyrektor}:rx lokaty
setfacl -d -m user:${det_dyrektor}:rx kredyty
setfacl -d -m user:${biz_dyrektor}:rx lokaty

setfacl -d -m group::r kredyty
setfacl -d -m group::r lokaty

setfacl -d -m user::rw kredyty
setfacl -d -m user::rw lokaty

setfacl -d -m user::rw zadania
setfacl -d -m group::r zadania
