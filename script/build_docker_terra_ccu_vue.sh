#!/bin/bash

docker stop instance-terra-ccu-vue
docker rm instance-terra-ccu-vue
docker rmi terra-ccu-vue
# 开发期间的Dockerfile为Nginx禁用缓存
# expires 1s;
docker build -t terra-ccu-vue -f ./Dockerfile .
