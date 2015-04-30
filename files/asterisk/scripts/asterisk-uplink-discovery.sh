#!/bin/bash
#Zabbix asterisk uplinks discovery implementation
POSITION=1
echo "{"
echo " \"data\":["
/usr/sbin/asterisk -x 'sip show peers' | grep -v '^Name\|^Asterisk\|offline]$\|\<D\>' | cut -d ' ' -f1| while read UPLINK;do
   if [ $POSITION -gt 1 ]
      then
       echo ","
   fi
echo -n " { \"{#UPLINK}\": \"$UPLINK\"}"
POSITION=$[POSITION+1]
done
echo ""
echo " ]"
echo "}"
