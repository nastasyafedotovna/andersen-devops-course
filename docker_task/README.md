### Docker task
* Run ```sudo ./task.sh``` or just ```./task.sh``` if your user in ```docker``` group
* If you want - you can change build parameters in Dockerfile
* Required components are listed in the file requirements.txt (flask and emoji)
* After building and starting the container, the application responds to requests like
* "curl -XPOST -d'{"word":"cat", "count": 5}' http://192.168.0.50:1080"
