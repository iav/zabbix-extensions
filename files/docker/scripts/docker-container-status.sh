#!/usr/bin/env bash
# Author: Mamedaliev K.O.
# Get docker container status.

DOCKER=$(which docker)
CONTAINER_NAME=$1
CMD="${DOCKER} inspect --format '{{ .State.Running }}'"

failed () {
  echo "ZBX_NOTSUPPORTED";exit 1
}

STATUS=$(${DOCKER} inspect ${CONTAINER_NAME} --format '{{ .State.Running }}') || failed

case ${STATUS} in
  'true') RESULT=0;
    ;;
  'false') RESULT=1;
    ;;
  *) failed;;
esac

if [ ! -z "${RESULT}" ];then echo ${RESULT} ; exit 0;
  else failed
fi
