#!/usr/bin/env bash
# Author:	Lesovsky A.V. <lesovsky@gmail.com>
# Description:	Flashcache volumes auto-discovery

dms=$(for dm in $(sudo dmsetup ls |awk '{print $1}'); do if (sudo dmsetup status $dm |grep flashcache &> /dev/null); then echo $dm; fi; done)
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for dm in ${dms}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#DMNAME}\":\"$dm\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
