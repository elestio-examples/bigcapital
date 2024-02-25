#!/usr/bin/env bash
mv ./docker/mongo/* ./
docker buildx build . --no-cache --output type=docker,name=elestio4test/bigcapital-mongo:latest | docker load