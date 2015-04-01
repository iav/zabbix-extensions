#!/usr/bin/env bash
# Author:       Kirill Mamedaliev <danteg41@gmail.com>
# Description:  Logstash instance auto-discovery

insts=$(curl -s http://127.0.0.1:9200/_aliases?pretty=1|awk -F - '/-20/ {gsub("\"","",$1);print $1}'|sort|uniq)


printf "{\n";
printf "\t\"data\":[\n\n";

for inst in ${insts}
do
    printf "\t{\n";
    printf "\t\t\"{#INDEX}\":\"$inst\"\n";
    printf "\t},\n";
done

printf "\n\t]\n";
printf "}\n";
