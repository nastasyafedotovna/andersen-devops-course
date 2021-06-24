#!/bin/bash
name="docker_task_gizar"
docker image build -t ${name} .
docker container run --rm -dp 8080:8080 --name ${name} ${name}
status=$(docker inspect ${name} --format '{{ .State.Status }}')
if [[ $status=="running" ]];then
  sleep 1
  curl -XPOST -d'{"animal":"dog", "sound":"bark", "count": 6}' 127.0.0.1:8080
  docker container stop ${name}
fi
