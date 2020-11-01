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

# tworzymy grupy
addgroup DBB
addgroup DBD

# konta dyrektorów
adduser biz_dyrektor
adduser det_dyrektor

mkdir kredyty
chmod a+rwxt kredyty

mkdir lokaty
chmod a+rwxt lokaty

setfacl -d -m user:biz_dyrektor:r kredyty
setfacl -d -m user:biz_dyrektor:r lokaty
setfacl -d -m user:det_dyrektor:r kredyty
setfacl -d -m user:biz_dyrektor:r lokaty

mkdir zadania
