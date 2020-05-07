#!/bin/bash

# Checking if Test Environment Code directory is present
if ! ls /opt/ | grep "test-env";then
	## Crate Test Environment Code directory in its absence 
  sudo mkdir /opt/test-env
else
  sudo rm -rf /opt/test-env/
fi

# Deploying master branch code to the Test environment
sudo cp -ap . /opt/test-env/

# Checking if docker dameon is active and running
if ! sudo systemctl status docker >/dev/null ; then
	systemctl start docker
fi

# Checking whether production is already live 
if sudo docker ps  | grep "test_env_web" >/dev/null; then
	echo "Test Environment Container already running"

elif sudo docker ps -a | grep "test_env_web" >/dev/null; then
	echo "Test Environment container was in stopped state"
    	echo "Starting Test Environment"
    	sudo docker start test_env_web

else
	echo "Test Environment is not live. Going on Live now"
	if ! sudo docker network ls | grep "test_env_application" >/dev/null; then
    		sudo docker network create --subnet 10.170.12.0/24  --driver bridge test_env_application
    	fi
	sudo docker run -dit --network test_env_application -v /opt/test-env/:/usr/local/apache2/htdocs/ --name test_env_web -p 8080:80 httpd:alpine

fi
