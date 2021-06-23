#!/bin/bash
name="docker_task_gizar"
docker build -t ${name} .
docker run --rm -dp 8080:8080 --name ${name} ${name}
if [[ ! $? -ne 0 ]];then
  sleep 1
  curl -XPOST -d'{"animal":"dog", "sound":"bark", "count": 6}' 127.0.0.1:8080
  docker stop ${name}
fi
