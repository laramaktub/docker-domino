#!/bin/bash
# Prepare the environment to run with graphic interface

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
input_path=$1

echo "Please enter the path to your input files:" 

echo ""
read inputpath
echo "Please enter the path to your outputfolder:" 

echo ""
read outputpath

sudo docker run -ti -v /home/lara/DOMINO-1.0.1/:/home/lara -v $inputpath:/input -v $outputpath:/output -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH laramaktub/docker-domino DOMINO
