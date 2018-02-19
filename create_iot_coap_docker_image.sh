#!/bin/sh
# -----------------------------------------------------------------------------
# Script bash to create docker image for iot-coap project
# Author: Yassir Sennoun
# -----------------------------------------------------------------------------

cmd=$(docker images | grep iot-coap-docker-image:0.0.1)
[ ! -z "${cmd}" ] && echo "Image already created"
[ -z "${cmd}" ] && docker build -t iot-coap-docker-image:0.0.1 docker-files/. && echo "Image created"



