#!/bin/bash
#Zabbix cave.pkg.discovery implementation
POSITION=1
echo "{"
echo " \"data\":["
/usr/bin/cave-report.sh|tail -n +2|while read STPKG PKG;do
   if [ $POSITION -gt 1 ]
      then
       echo ","
   fi
echo -n " { \"{#PKGNAME}\": \"$PKG\"}"
POSITION=$[POSITION+1]
done
echo ""
echo " ]"
echo "}"
