#!/bin/sh
# -----------------------------------------------------------------------------
# Script bash to delete docker image for iot-coap project
# Author: Yassir Sennoun
# -----------------------------------------------------------------------------

cmd=$(docker images | grep iot-coap-docker-image:0.0.1)
[ -z "${cmd}" ] && echo "Image already deleted"
[ ! -z "${cmd}" ] && docker rmi -f iot-coap-docker-image:0.0.1 && echo "Image deleted"




