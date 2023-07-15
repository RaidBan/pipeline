#!/bin/bash
prog=$(ls *.py)
echo program name: $prog
echo -e "FROM python:3.10.6 \nCOPY ./$prog . \nENTRYPOINT python3 $prog" > Dockerfile
dockerid=$(docker build . | grep Successfully | awk '{print $3}')
echo docker image id: $dockerid
echo program cli:
docker run $dockerid --name jenkinsdocker

containerid=$(docker ps -a | grep $dockerid | awk '{print $1}')
echo deleted container: 
docker rm $containerid
echo -e "\ndeleted image: "
docker image rm $dockerid
echo -e "\n"

