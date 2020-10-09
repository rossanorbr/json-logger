#!/bin/sh
while [ 1 ]
do
   waitTime=$(shuf -i 1-5 -n 1)
   sleep $waitTime &
   wait $!
   instruction=$(shuf -i 0-4 -n 1)
   d=`date -Iseconds`
   case "$instruction" in
      "1") echo "{\"@timestamp\": \"$d\", \"kubernetes.json.level\": \"ERROR\", \"kubernetes.json.status\": \"500\", \"kubernetes.json.logger\": \"jsonLogger\", \"kubernetes.json.context\": \"default\", \"kubernetes.json.message\": \"something happened in this execution.\"}"
      ;;
      "2") echo "{\"@timestamp\": \"$d\", \"kubernetes.json.level\": \"INFO\", \"kubernetes.json.status\": \"200\", \"kubernetes.json.logger\": \"jsonLogger\", \"kubernetes.json.context\": \"default\", \"kubernetes.json.message\": \"everything is ok.\"}"
      ;;
      "3") echo "{\"@timestamp\": \"$d\", \"kubernetes.json.level\": \"WARN\", \"kubernetes.json.status\": \"301\", \"kubernetes.json.logger\": \"jsonLogger\", \"kubernetes.json.context\": \"default\", \"kubernetes.json.message\": \"your request got redirected.\"}"
      ;;
      "4") echo "{\"@timestamp\": \"$d\", \"kubernetes.json.level\": \"DEBUG\", \"kubernetes.json.status\": \"404\", \"kubernetes.json.logger\": \"jsonLogger\", \"kubernetes.json.context\": \"default\", \"kubernetes.json.message\": \"request not found.\"}"
      ;;
   esac
done
