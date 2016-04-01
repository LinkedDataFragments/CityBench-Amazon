#!/bin/bash
# Places bootstrap scripts on host $1
ssh -i ~/Documents/Admin/amazon_ldf_rtaelman.pem ec2-user@$1 'mkdir -p /home/ec2-user/citybench'
scp -i ~/Documents/Admin/amazon_ldf_rtaelman.pem bootstrap.sh bootstrap-client.sh user_bootstrap.sh ec2-user@$1:/home/ec2-user/citybench
