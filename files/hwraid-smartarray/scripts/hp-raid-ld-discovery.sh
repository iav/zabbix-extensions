#!/usr/bin/env bash
# Author:       Lesovsky A.V.
# Descriprion:  Low-level discovery for HP Smart Array logical volumes

data="/tmp/hp-raid-data-harvester.out"
first=1

if [ -f $data ]; then
  ld_list=$(sed -n -e '/ld section begin/,/ld section end/p' $data |grep -w 'ld begin' |awk '{OFS=":"} {print $4,$5}')
  else echo "$data not found."; exit 1
fi

if [[ $1 = raw ]]; then
  for line in ${ld_list}; do echo $line; done ; exit 0
fi

printf "{\n";
printf "\t\"data\":[\n\n";

for line in ${ld_list}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#LD}\":\"$line\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
