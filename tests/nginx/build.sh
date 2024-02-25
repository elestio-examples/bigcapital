#!/usr/bin/env bash
mv ./docker/nginx/* ./
docker buildx build . --no-cache --output type=docker,name=elestio4test/bigcapital-nginx:latest | docker load