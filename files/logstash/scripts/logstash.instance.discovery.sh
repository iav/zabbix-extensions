#!/usr/bin/env bash
# Author:       Kirill Mamedaliev <danteg41@gmail.com>
# Description:  Logstash instance auto-discovery

insts=$(/sbin/rc-service -l|/bin/grep -P "logstash\."|awk -F . '{print $2}')
first=1

printf "{\n";
printf "\t\"data\":[\n\n";

for inst in ${insts}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#INSTANCE}\":\"$inst\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
