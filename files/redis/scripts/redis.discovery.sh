#!/usr/bin/env bash
# Author:   Lesovsky A.V.
# Description:  Get values stored in Redis keys

getValues=$(redis-cli --raw $1 $2)
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for value in ${getValues}
do
  [ $first != 1 ] && printf ",\n";
  first=0;
  printf "\t{\n";
  printf "\t\t\"{#VALUE}\":\"$value\"\n";
  printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
