#!/bin/bash
# Initiate client installation on the host $1
ssh -i cert.pem ec2-user@$1 'sudo /home/ec2-user/citybench/bootstrap-client.sh > /var/tmp/boot.log 2>&1'

