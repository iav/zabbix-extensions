#!/bin/bash
#Zabbix cave.pkg.discovery implementation

PACKAGELIST=$(awk 'NR != 1 {print $2"-"$3}' <(/usr/bin/cave-report.sh))
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for package in ${PACKAGELIST}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#PKGNAME}\":\"${package}\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
