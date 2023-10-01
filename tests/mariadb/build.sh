#!/usr/bin/env bash
mv ./docker/mariadb/* ./
docker buildx build . --output type=docker,name=elestio4test/bigcapital-mariadb:latest | docker load