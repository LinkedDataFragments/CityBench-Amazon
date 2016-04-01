#!/usr/bin/env bash
# THIS MUST BE RUN ON THE EXPERIMENT SERVER MACHINE
# Start script for the citybench tests on amazon

# Clone benchmark docker container
if [ ! -d "container" ]; then
    git clone https://github.com/rubensworks/TPFStreamingQueryExecutor-CityBench.git container
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
# network: host-mode because we want to be able to access network using hostnames, and reduces overhead.
docker run -d --net="host" -p 3001:3001 -v $dir:/home/citybench/CityBench/result_log/ citybench > $dir/docker.log

