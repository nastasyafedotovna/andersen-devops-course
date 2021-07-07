#!/bin/bash
yum -y update
yum -y install nginx

sudo systemctl enable nginx
sudo systemctl start nginx
chkconfig nginx on