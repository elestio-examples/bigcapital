#!/usr/bin/env bash
mv ./docker/migration/* ./
chmod +x ./start.sh
sed -i "s~mysql~mariadb~g" ./start.sh
sed -i "s~ADD docker/migration/start.sh~ADD ./start.sh~g" ./Dockerfile
docker buildx build . --no-cache --output type=docker,name=elestio4test/bigcapital-migration:latest | docker load