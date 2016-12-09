#!/usr/bin/env bash
# Author:       Mamedaliev K.O. <danteg41@gmail.com>
# Description:  dm-cache volumes auto-discovery

dms=$(awk '$4 == "cache" {gsub(":$","",$1);print $1}' <(sudo dmsetup table))

printf "{\n";
printf "\t\"data\":[\n\n";

for dm in ${dms}
do
    printf "\t{\n";
    printf "\t\t\"{#DMNAME}\":\"$dm\"\n";
    printf "\t},\n";
done

printf "\n\t]\n";
printf "}\n";
