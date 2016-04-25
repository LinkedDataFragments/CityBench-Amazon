#!/usr/bin/env bash
# THIS MUST BE RUN ON THE EXPERIMENT CLIENT MACHINE
# Bootstrap script for clients for the citybench tests on amazon

SERVER_IP="10.0.0.218"

# Install required packages
yum update -y
yum install -y docker git
service docker start

# Make an UNSAFE ssh user
groupadd remote
ADMIN=remote-admin
useradd -d /home/$ADMIN -G remote -m $ADMIN
passwd -d $ADMIN
passwd $ADMIN <<EOF
remote-admin
remote-admin
EOF
echo "$ADMIN ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Make sure 'server' is present in hosts
echo "$SERVER_IP server" >> /etc/hosts

# Clone client and build docker container
mkdir -p /var/tmp/
cd /var/tmp/
git clone -b iswc2016-citybench https://github.com/LinkedDataFragments/QueryStreamer.js.git client
cd client
docker build -t tpfqs-client .
