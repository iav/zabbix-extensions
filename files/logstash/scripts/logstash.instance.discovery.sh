#!/usr/bin/env bash
# Author:       Kirill Mamedaliev <danteg41@gmail.com>
# Description:  Logstash instance auto-discovery

insts=$(/sbin/rc-service -l|/bin/grep -P "logstash\."|awk -F . '{print $2}')

printf "{\n";
printf "\t\"data\":[\n\n";

for inst in ${insts}
do
    printf "\t{\n";
    printf "\t\t\"{#INSTANCE}\":\"$inst\"\n";
    printf "\t},\n";
done

printf "\n\t]\n";
printf "}\n";
