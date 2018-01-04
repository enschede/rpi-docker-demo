#!/usr/bin/env bash

# 1. Push versies naar Docker Hub
# 2. Deploy: docker stack deploy -c docker-compose.yaml demo1
# 3. Pas node2 aan, verhoog het versienummer naar 0.0.2
# 4. Redeploy met hetzelfde command

docker push enschede/docker-node1:0.0.1-SNAPSHOT
docker push enschede/docker-node2:0.0.1-SNAPSHOT
docker push enschede/docker-node2:0.0.2-SNAPSHOT
