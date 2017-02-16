#!/bin//bash

HOST=$1
PORT=${2:-443}
PROTO=$3

failed() {
  echo "ZBX_NOTSUPPORTED";exit 1
}

[ -z $1 ] && failed

OPENSSL=$(which openssl)
CMD="${OPENSSL} s_client -servername ${HOST} -host ${HOST} -port ${PORT}"
if [ ! -z ${PROTO} ];then 
  CMD="${CMD} -starttls ${PROTO}"
fi
ENDDATE=$(${OPENSSL} x509 -enddate -noout -in <(${CMD} 2>/dev/null) 2>/dev/null) || failed
TIMESTAMP=$(date '+%s' --date "${ENDDATE//notAfter=}") || failed

if [ ! -z "${TIMESTAMP}" ];then echo ${TIMESTAMP};exit 0
  else failed
fi
