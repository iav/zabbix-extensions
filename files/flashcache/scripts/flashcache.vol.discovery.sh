#!/usr/bin/env bash
# Author:       Lesovsky A.V. <lesovsky@gmail.com>
# Description:	Flashcache volumes auto-discovery

if [ ! -d /proc/flashcache ]; then exit 1; fi

volumes=$(ls -1d /proc/flashcache/*/ 2> /dev/null |cut -d\/ -f4)
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for vol in ${volumes}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#VOLNAME}\":\"$vol\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
