#!/bin/bash
#Zabbix vfs.dev.discovery implementation

DEVS=$(awk '!/(loop|^$|sr[0-9]+)/ && NR!=1 {print$4}' /proc/partitions)
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for DEV in ${DEVS}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#DEVNAME}\":\"${DEV}\",\n";
    printf "\t\t\"{#DEVMOUNT}\":\"$(lsblk -dno MOUNTPOINT /dev/${DEV})\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
