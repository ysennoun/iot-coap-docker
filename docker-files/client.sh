#!/bin/sh
# -----------------------------------------------------------------------------
# Script bash to run CoAP client
# Author: Yassir Sennoun
# -----------------------------------------------------------------------------

# Arguments

syntax="INVALID ARGUMENTS: client.sh <CoAP SERVER URI> <METHOD_NAME>"
[ "$#" -ne 2 ] && echo $syntax && exit 1;
serverUri=$1
method=$2

echo "
ServerURI --> $serverUri
MethodName --> $method
"

# run publisher

java -cp jars/iot-coap-1.0-SNAPSHOT-jar-with-dependencies.jar com.xebia.iot.coap.main.ClientMain ${serverUri} ${method}
