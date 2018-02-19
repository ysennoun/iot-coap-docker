#!/bin/sh
# -----------------------------------------------------------------------------
# Script bash to run CoAP server
# Author: Yassir Sennoun
# -----------------------------------------------------------------------------

# Arguments

syntax="INVALID ARGUMENTS: server.sh <CONFIGURATION_FILE_PATH>"
[ "$#" -ne 1 ] && echo $syntax && exit 1;
configFilePath=$1

echo "
ConfigFilePath --> $configFilePath
"

# run publisher

java -cp jars/iot-coap-1.0-SNAPSHOT-jar-with-dependencies.jar com.xebia.iot.coap.main.ServerMain ${configFilePath}
