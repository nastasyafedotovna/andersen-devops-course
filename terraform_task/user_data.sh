#!/bin/bash
sudo yum -y update
sudo amazon-linux-extras install nginx1 -y
aws s3 cp s3://gizarzigangirovandersenhw/index.html index.html
sudo mv -f index.html /usr/share/nginx/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx