#!/bin/bash
echo $(docker run -d --name "cache" \
--privileged=true \
-v $(pwd)/nginx-default:/etc/nginx/sites-enabled/default:ro \
-v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro \
-v $(pwd)/tmp-cache:/tmp/cache/nginx \
-v $(pwd)/tmp-nginx:/tmp/nginx \
-v $(pwd)/logs:/data/log/nginx \
-p 3001:3001 \
nginx:stable)

