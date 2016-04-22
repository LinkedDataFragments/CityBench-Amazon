#!/bin/bash
# Places bootstrap scripts on host $1
ssh -i cert.pem ec2-user@$1 'mkdir -p /home/ec2-user/citybench'
scp -i cert.pem bootstrap.sh bootstrap-client.sh user_bootstrap.sh start-cache.sh stop-cache.sh nginx-default nginx.conf ec2-user@$1:/home/ec2-user/citybench
