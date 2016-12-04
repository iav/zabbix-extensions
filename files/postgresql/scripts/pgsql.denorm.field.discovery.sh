#!/bin/sh
# Author: Mamedaliev Kirill
# Обнаружение полей денормализации

username=$(head -n 1 ~zabbix/.pgpass |cut -d: -f4)

#если имя базы не получено от сервера, то имя берется из ~zabbix/.pgpass
if [ -z "$*" ]; 
  then 
    if [ ! -f ~zabbix/.pgpass ]; then echo "ERROR: ~zabbix/.pgpass not found" ; exit 1; fi
    dbname=$(head -n 1 ~zabbix/.pgpass |cut -d: -f3);
  else
    dbname="$1"
fi

fields=$(psql -h localhost -U $username -t --dbname=$dbname -c "SELECT title FROM denormalization.fields;")
exit_code=$?

if [ $exit_code != 0 ]; then
        printf "Error : [%d] when executing query '$q'\n" $exit_code
        exit $exit_code
else

printf "{\n";
printf "\t\"data\":[\n\n";

for line in ${fields}
do
    printf "\t{\n";
    printf "\t\t\"{#FIELD}\":\"$line\"\n";
    printf "\t},\n";
done

printf "\n\t]\n";
printf "}\n";

fi
