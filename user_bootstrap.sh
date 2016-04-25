#!/usr/bin/env bash
# THIS MUST BE RUN ON THE EXPERIMENT SERVER MACHINE
# Start script for the citybench tests on amazon

# Clone benchmark docker container
if [ ! -d "container" ]; then
    git clone https://github.com/rubensworks/LinkedDataFragments/CityBench-Docker.git container
    cd container
    dir="/home/ec2-user/citybench/output/"
    rm -rf $dir
    mkdir -p $dir
    docker build --no-cache -t citybench .
else
    cd container
    dir="/home/ec2-user/citybench/output/"
    rm -rf $dir
    mkdir -p $dir
    docker build -t citybench .
fi

cd /home/ec2-user/citybench/

# Start proxy (exposes 3001 and forwards to 3002)
docker pull nginx:stable
id=$(./start-cache.sh)
echo "Cache started at $id"

# network: host-mode because we want to be able to access network using hostnames, and reduces overhead.
docker run --name server -d --net="host" -p 3002:3001 -v $dir:/home/citybench/CityBench/result_log/ -v /home/ec2-user/citybench/tmp-cache:/home/citybench/tmp-cache citybench > $dir/docker.log

#./stop-cache.sh $id

