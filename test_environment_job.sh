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
if sudo docker ps -a | grep "test_env_web" >/dev/null; then
    echo "Test Environment Container already present"
    echo "Removing Test Environment"
    sudo docker rm -f test_env_web

else
	echo "Test Environment is not live. Going on Live now"
	if ! sudo docker network ls | grep "test_env_application" >/dev/null; then
    		sudo docker network create --subnet 10.170.12.0/24  --driver bridge test_env_application
    	fi

fi

echo "Initialising Test Container"
sudo docker run -dit --network test_env_application -v /opt/test-env/:/usr/local/apache2/htdocs/ --name test_env_web -p 8085:80 httpd:alpine

