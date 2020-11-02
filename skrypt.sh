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
adduser --group dbb
adduser --group dbd

# konta dyrektorów
adduser --disabled-password --gecos "" biz_dyrektor
adduser --disabled-password --gecos "" det_dyrektor

mkdir kredyty
chmod a+rwxt kredyty

mkdir lokaty
chmod a+rwxt lokaty

mkdir zadania

setfacl -d -m other:-rw kredyty
setfacl -d -m other:-rw kredyty
setfacl -d -m user:biz_dyrektor:r kredyty
setfacl -d -m user:biz_dyrektor:r lokaty
setfacl -d -m user:det_dyrektor:r kredyty
setfacl -d -m user:biz_dyrektor:r lokaty

setfacl -d -m group::r kredyty
setfacl -d -m group::r lokaty

setfacl -d -m user::rw kredyty
setfacl -d -m user::rw lokaty

setfacl -d -m user::rw 
setfacl -d -m group::r