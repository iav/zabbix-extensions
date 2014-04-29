#!/usr/bin/env bash
pid_path=$1
RESQNPS=$(ps auxf | grep -E -c 'resqu[e].*?(Waiting|Forked)')
RESQNPIDS=$(find $pid_path/ -type f -name 'resque*.pid' -and -not -name '*god*' -exec pgrep -F {} \; | wc -l)
if [ "$RESQNPIDS" -ne "$RESQNPS" ]; then echo 1; else echo 0; fi
