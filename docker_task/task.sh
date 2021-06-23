name="docker_task_gizar"
docker build -t ${name} .
docker run --rm -dp 8080:8080 --name=${name} -v $PWD:/app ${name}
sleep 1
curl -XPOST -d'{"animal":"cat", "sound":"meoooow", "count": 12}' 127.0.0.1:8080
docker stop docker_task_gizar
