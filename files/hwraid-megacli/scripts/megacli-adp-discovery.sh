#!/usr/bin/env bash
# Author: Lesovsky A.V.
# Adapters auto-discovery via MegaCLI. VERY VERY EXPERIMENTAL (TESTED WITH 8.02.21 Oct 21, 2011)

megacli=$(which megacli)
adp_list=$(sudo $megacli adpallinfo aALL nolog |grep "^Adapter #" |cut -d# -f2)
first=1

if [[ $1 = raw ]]; then
  for adp in ${adp_list}; do echo $adp; done ; exit 0
fi

printf "{\n";
printf "\t\"data\":[\n\n";

for adp in ${adp_list}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#ADPNUM}\":\"$adp\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
