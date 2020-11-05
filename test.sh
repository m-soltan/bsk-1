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

su -c "./testy/a.sh ${1}" $det_dyrektor
# su -c "./testy/b.sh ${1}" $biz_dyrektor
# su -c "./testy/c.sh ${1}" $det_dyrektor
# su -c "./testy/d.sh ${1}" $biz_dyrektor

# każde z tych dwóch w pętli
# su -c "./testy/e.sh ${1}" $pracownik
# su -c "./testy/f.sh ${1}" $pracownik
# su -c "./testy/g.sh ${1}" $pracownik
