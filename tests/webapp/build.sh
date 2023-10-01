#!/usr/bin/env bash
mv ./packages/webapp/Dockerfile ./
docker buildx build . --output type=docker,name=elestio4test/bigcapital-webapp:latest | docker load