#!/usr/bin/env bash
# Author:	Lesovsky A.V.
# Description:	Glusterfs mounts auto-discovery

mountpoints=$(grep glusterfs /etc/fstab |grep -v ^# |awk '{print $2}')
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for mount in ${mountpoints}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#MOUNT}\":\"$mount\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
