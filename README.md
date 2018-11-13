# Exercise on CoAP protocol

## Files

The project is composed of :

- README.md
- create_iot_coap_docker_image.sh
- delete_iot_coap_docker_image.sh
- run_client_container.sh
- run_server_container.sh
- docker-files
  - Dockerfile
  - client.sh
  - server.sh
  - persisters_configuration_file.json
  - jars
    - iot-coap-1.0-SNAPSHOT-jar-with-dependencies.jar

## Context

This project enables to run 2 docker containers.

On one of these containers (named `client`) we will setup a  CoAP client. We will also run a tcpdump capture in order to visualize the packets exchanged with server.

On the other container (named `server`), we will run a server to receive CoAP request from client with the possibility to persist messages on console or on elasticsearch. With Kibana we will be able to visualize those messages. 

## Build the docker image

Execute the script `create_iot_coap_docker_image.sh` to create the image `iot-coap-docker-image:0.0.1`.

If you want to delete this image, you can run the script `delete_iot_coap_docker_image.sh`.

## Network verification

Execute command

	docker network ls | grep iot

If there is a network found, remote it:

	docker network rm <NETWORK_ID>

## Setup client and server

We will open two terminal where we will run two containers. One for a CoAP client and the other one for a CoAP server.

On the first terminal, execute

	sh run_client_container.sh
	cd /home

On the second terminal, execute

	sh run_server_container.sh
	cd /home

## Elasticsearch

On server 

	su - elasticuser
	export JAVA_HOME=/usr/bin/java/jdk1.8.0_191
	./elasticsearch/bin/elasticsearch > /dev/null 2>&1 &
	exit
	curl -XPUT 'http://localhost:9200/index_test/messages/first' -H "Content-Type: application/json" -d '{"name" : "xebia & iot-ee"}'

## Kibana

on server

	/usr/share/kibana/bin/kibana > /dev/null 2>&1 &
	
On your local desktop, open a browser and go to 

	localhost:5601

Verify index "index_test" was created.

## Start CoAP server
	
On server

	sh server.sh persisters_configuration_file.json

## Start CoAP client

Before starting a client, let's capture all packet exchanged between client and server. Thus, execute on client:

	tcpdump -U -w capture_network_exchange.pcap  &

### Hello World

Let's receive a simple message from CoAP server.

	sh client.sh coap://server:5683/helloWorld GET

### Simulate an action

Let's imagine a device which requests from a CoAP server the next action to apply according to the code number received.

	sh client.sh coap://server:5683/action GET

### Simulate the monitoring of a volume

Let's imagine a device which monitors a volume and sends periodically its value to a CoAP server.

	sh client.sh coap://server:5683/data/volume POST

Pay attention to the fact that we have defined a subpath `data` in the resource.

### Simulate the monitoring of a position

Let's imagine a device which monitors a position and sends periodically its value to a CoAP server.

	sh client.sh coap://server:5683/data/position POST

## Analysis of network exchange

Retrieve the file `capture_network_exchange.pcap` on your local desktop by executing the command below on a new terminal:

	docker cp <CONTAINER_ID_of_client>:/home/capture_network_exchange.pcap .

The file format `pcap` is readable with wireshark, thus download `wireshark` and open it. Finally, analyse the packet exchanged.

