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

mkdir kredyty
chmod a+rwx kredyty

mkdir lokaty
chmod a+rwx lokaty

mkdir zadania
