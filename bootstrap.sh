#!/usr/bin/env bash
# THIS MUST BE RUN ON THE EXPERIMENT SERVER MACHINE
# Bootstrap script for the citybench tests on amazon

# Install required packages
yum update -y
yum install -y docker git
service docker start

mkdir -p /var/tmp/citybench
cp /home/ec2-user/citybench/user_bootstrap.sh /var/tmp/citybench/user_bootstrap.sh
chmod -R 777 /var/tmp/citybench

