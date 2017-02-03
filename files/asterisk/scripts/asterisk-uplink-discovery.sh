#!/bin/bash
#Zabbix asterisk uplinks discovery implementation

UPLINKS=$(awk '!/(^Name|^Asterisk|offline]$|\<D\>)/ {print $1}' <(sudo /usr/sbin/asterisk -x 'sip show peers'))
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for uplink in ${UPLINKS}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#UPLINK}\":\"${uplink}\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
