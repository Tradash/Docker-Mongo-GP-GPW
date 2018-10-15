#!/bin/bash
docker stop $(docker ps -f "name=tradash-")
docker rm $(docker ps -f "name=tradash-")
docker rmi -f $(docker images "*tradash-*" -q)

if [ -d ./gp ]; then 
rm -rf ./gp
fi
if [ -d ./gpw ]; then 
rm -rf ./gpw
fi

git clone https://github.com/tradash/gp
git clone https://github.com/tradash/gpw

sed -i 's/localhost:27017/tradash-mongo:27017/g' ./gp/dbprovider.js
sed -i 's/localhost:27017/tradash-mongo:27017/g' ./gpw/dbprovider.js

cp gp-dockerfile ./gp/dockerfile
cp gpw-dockerfile ./gpw/dockerfile

docker-compose build
docker-compose up

