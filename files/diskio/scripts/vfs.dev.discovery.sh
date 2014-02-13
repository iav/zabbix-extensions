#!/bin/bash
#Zabbix vfs.dev.discovery implementation
DEVS=`grep -E -v "major|^$|loop" /proc/partitions | awk '{print $4}'`
POSITION=1
echo "{"
echo " \"data\":["
for DEV in $DEVS
do
   if [ $POSITION -gt 1 ]
     then
       echo ","
   fi
 echo  " { \"{#DEVNAME}\": \"$DEV\","
 echo -n "  \"{#DEVMOUNT}\": \"`lsblk |grep $DEV|awk '{print $8}'`\"}"
 POSITION=$[POSITION+1]
done
echo ""
echo " ]"
echo "}"
