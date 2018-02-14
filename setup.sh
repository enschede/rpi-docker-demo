#!/usr/bin/env bash

docker-machine create -d virtualbox server1 &
sleep 10
docker-machine create -d virtualbox server2 &
sleep 10
docker-machine create -d virtualbox server3 &
wait
eval $(docker-machine env server1)
docker swarm init --advertise-addr 192.168.99.100
docker service create --name=viz --publish=9001:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer
export token=`docker swarm join-token -q worker`
eval $(docker-machine env server2)
docker swarm join --token $token 192.168.99.100:2377
eval $(docker-machine env server3)
docker swarm join --token $token 192.168.99.100:2377