#!/bin/sh
# -----------------------------------------------------------------------------
# Script bash to create docker container for iot-coap project
# Author: Yassir Sennoun
# -----------------------------------------------------------------------------

cmd=$(docker network list | grep iot-coap-network)
[ -z "${cmd}" ] && docker network create --subnet=192.168.1.0/16 iot-coap-network && "Docker network iot-coap-network created"

docker run --net iot-coap-network --hostname client --ip 192.168.1.20 --add-host server:192.168.1.21 -it iot-coap-docker-image:0.0.1 bash
