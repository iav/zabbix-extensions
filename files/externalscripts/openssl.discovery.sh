#!/bin/bash

FILE=$1
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

while read host
do
  [ $first != 1 ] && printf ",\n";
  first=0;
  printf "\t{\n";
  printf "\t\t\"{#HOST}\":\"$host\"\n";
  printf "\t}";
done < ${FILE}

printf "\n\t]\n";
printf "}\n";
