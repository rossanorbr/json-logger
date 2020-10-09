# Json log generator



How to use(docker):
```sh
$ docker push rossanorbr/json-logger:v1
$ docker run -d rossanorbr/json-logger:v1
```
It will generate outputs in json format, its defined inside [entrypoint.sh](https://github.com/rossanorbr/json-logger/blob/master/entrypoint.sh):
```sh
{"@timestamp": "2020-10-09T07:22:44+0000", "kubernetes.json.level": "DEBUG", "kubernetes.json.status": "404", "kubernetes.json.logger": "jsonLogger", "kubernetes.json.context": "default", "kubernetes.json.message": "request not found."}

{"@timestamp": "2020-10-09T07:27:10+0000", "kubernetes.json.level": "INFO", "kubernetes.json.status": "200", "kubernetes.json.logger": "jsonLogger", "kubernetes.json.context": "default", "kubernetes.json.message": "everything is ok."}

{"@timestamp": "2020-10-09T07:27:14+0000", "kubernetes.json.level": "ERROR", "kubernetes.json.status": "500", "kubernetes.json.logger": "jsonLogger", "kubernetes.json.context": "default", "kubernetes.json.message": "something happened in this execution."}
```
If you want to change the logs output just change the [entrypoint.sh](https://github.com/rossanorbr/json-logger/blob/master/entrypoint.sh) file:
```sh
$ git clone git@github.com:rossanorbr/json-logger.git
$ cd json-logger/
$ cat entrypoint.sh

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
```

Kubernetes use case:

```sh
$ kubectl apply -f https://raw.githubusercontent.com/rossanorbr/json-logger/master/logger.yaml
```

