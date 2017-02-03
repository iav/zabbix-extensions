#!/usr/bin/env bash
# Author:       Mamedaliev K.O.
# Description:  redis atracers discovery

controllers=$(redis-cli --raw keys counter_"*"_request|sed -e 's/^counter_//' -e 's/_request$//')
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for contr in ${controllers}
do
	[ $first != 1 ] && printf ",\n";
	first=0;
	printf "\t{\n";
	printf "\t\t\"{#CONTROLLERNAME}\":\"${contr%#*}\",\n";
	printf "\t\t\"{#ACTIONNAME}\":\"${contr#*#}\"\n";
	printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
