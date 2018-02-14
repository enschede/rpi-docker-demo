#!/usr/bin/env bash

cd `dirname $0`

function run() {
    eval "$0 $INSTANCE $1"
}

case "$1" in
    clean)
        docker image rm -f `docker image ls | grep $2 | awk '{print \$3}'`
    ;;
    setups)
        docker-machine create -d virtualbox server1
        docker-machine create -d virtualbox server2
        docker-machine create -d virtualbox server3
        eval $(docker-machine env server1)
        docker swarm init --advertise-addr 192.168.99.100
        export token=`docker swarm join-token -q worker`
        eval $(docker-machine env server2)
        docker swarm join --token $token 192.168.99.100:2377
        eval $(docker-machine env server3)
        docker swarm join --token $token 192.168.99.100:2377
    ;;
    viz)
        docker service create --name=viz --publish=9001:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer
    ;;
    push)
        docker push enschede/docker-node1
        docker push enschede/docker-node2
    ;;
    *)
      echo $"Commands:"
      echo $"rpi clean \$2    Remove all images containing \$2"
      echo $"rpi setups      Create swarm"
      echo $"rpi push        "

    ;;
esac
