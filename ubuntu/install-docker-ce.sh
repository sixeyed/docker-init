#!/bin/bash

CHANNEL=${CHANNEL:-edge}

sudo apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl

sudo apt-get remove -y docker-engine docker.io || true

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       $CHANNEL"

sudo apt-get update

sudo apt-get -y install docker-ce

sudo docker version
