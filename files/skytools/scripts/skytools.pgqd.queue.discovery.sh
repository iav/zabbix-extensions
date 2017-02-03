#!/usr/bin/env bash
# Author: 	Lesovsky A.V.
# Description:	PGQ queues auto-discovery

username=$(head -n 1 ~zabbix/.pgpass |cut -d: -f4)
first=1

#если имя базы не получено от сервера, то имя берется из ~zabbix/.pgpass
if [ -z "$*" ]; 
  then 
    if [ ! -f ~zabbix/.pgpass ]; then echo "ERROR: ~zabbix/.pgpass not found" ; exit 1; fi
    dbname=$(head -n 1 ~zabbix/.pgpass |cut -d: -f3);
  else
    dbname="$1"
fi

queuelist=$(psql -qAtX -h localhost -U $username $dbname -c "select pgq.get_queue_info()" |cut -d, -f1 |tr -d \()


printf "{\n";
printf "\t\"data\":[\n\n";

for queue in ${queuelist}
do
    [ $first != 1 ] && printf ",\n";
    first=0;
    printf "\t{\n";
    printf "\t\t\"{#QNAME}\":\"$queue\"\n";
    printf "\t}";
done

printf "\n\t]\n";
printf "}\n";
