#!/usr/bin/env bash
mv ./docker/redis/* ./
docker buildx build . --no-cache --output type=docker,name=elestio4test/bigcapital-redis:latest | docker load