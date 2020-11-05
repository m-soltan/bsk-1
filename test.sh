#!/usr/bin/bash


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
			if [[ ${w[4]} == $BIZ_GR ]]; then
				biz_dyrektor=$nazwa
			else
				det_dyrektor=$nazwa
			fi
		fi
	fi
	(( ++index ))
done

# podpunkt a
function test_a {
	cd zadania
	index=5
	for i in $(cat $1); do
		if [[ $index == 4 ]]; then
			printf "kredyt" > $i/z1.txt
			printf "lokata" > $i/z2.txt
			index=0
		fi
		(( ++index ))
	done
}

su -c="test_a $1" $det_dyrektor

# podpunkt b
function test_b {
	cd zadania
	index=5
	for i in $(cat $1); do
		if [[ $index == 4 ]]; then
			printf "kredyt" > $i/z1.txt
			printf "kredyt" > $i/z2.txt
			printf "lokata" > $i/z3.txt
			index=0
		fi
		(( ++index ))
	done	
}

su -c="test_b $1" $biz_dyrektor

# podpunkt c
function test_c {
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
}

su -c="test_c $1" $det_dyrektor
