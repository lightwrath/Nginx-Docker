#!/bin/bash
source lightwrath_deploy_beta.conf 
mkdir $dockerFiles/$name-$port
mkdir $dockerFiles/$name-$port/nginx-html
mkdir $dockerFiles/$name-$port/nginx-logs
cp -r $sourceFiles $dockerFiles/$name-$port/nginx-html
sudo docker run -d --name $name-$port -e TERM=xterm -v $dockerFiles/$name-$port/nginx-logs:/var/log/nginx:z -v $dockerFiles/$name-$port/nginx-html:/usr/local/nginx/html:z -p $port:80 nginx
echo "Deployment complete"
newPort=$((port+1))
sed -i -r "s/port=$port/port=$newPort/" lightwrath_deploy_beta.conf