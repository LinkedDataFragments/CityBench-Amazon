#!/bin/bash
# Start the experiment at the server at host $1
ssh -i cert.pem ec2-user@$1 'cd /var/tmp/citybench && sudo ./user_bootstrap.sh > /var/tmp/run.log 2>&1'

