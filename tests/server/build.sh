#!/usr/bin/env bash
mv ./packages/server/Dockerfile ./
docker buildx build . --output type=docker,name=elestio4test/bigcapital-server:latest | docker load