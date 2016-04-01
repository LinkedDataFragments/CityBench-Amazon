#!/bin/bash
# Fetches experiment result files from host $1
scp -ri ~/Documents/Admin/amazon_ldf_rtaelman.pem ec2-user@$1:/home/ec2-user/citybench/output/ amazon-output
