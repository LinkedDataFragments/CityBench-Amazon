#!/bin/bash
# This is a convenience script to be used when new machines are created on amazon,
# this does the things after install-client which can't be automated.

# $1: The PUBLIC server hostname
# $2: The PRIVATE client ip
# $3: The id of the client, this will be prefixed with 'c' to form the hostname of the client
# $4: The PUBLIC client hostname (SSH host key will be ignored, so this may hostname may be temporary and used by other machines later on)
server=$1
client=$2
clientid=$3
publicclient=$4

# Disable ssh keys on client
ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i ~/Documents/Admin/amazon_ldf_rtaelman.pem ec2-user@$publicclient "sudo sed -c -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && sudo service sshd restart" 

# Add client to host on server
ssh -i ~/Documents/Admin/amazon_ldf_rtaelman.pem ec2-user@$server "echo '$client c$clientid' | sudo tee -a /etc/hosts"

# Add to file
echo "c$clientid $client" >> clients.txt

