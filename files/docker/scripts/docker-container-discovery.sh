#!/usr/bin/env bash
# Author: Mamedaliev K.O.
# Docker container discovery with filter by label.

DOCKER=$(which docker)
LABEL=$1
CMD="${DOCKER} ps -a --no-trunc --format {{.Names}}"
first=1

if [ ! -z ${LABEL} ];then
    containers_list=$(${CMD} --filter label="${LABEL}")
else
    containers_list=$(${CMD})
fi

printf "{\n";
printf "\t\"data\":[\n\n";

for name in ${containers_list}
do
    [ $first != 1 ] && printf ",\n";
    first=0
    printf "\t{\n";
    printf "\t\t\"{#DCNAME}\":\"$name\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
