#!/bin/bash
# Prepare the environment to run with graphic interface

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
exectype=$1

if [ $exectype = "gui" ];
then
        echo "Running docker in GUI mode"
	sudo docker run -ti  -v $HOME:$HOME -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH laramaktub/docker-domino DOMINO

else

	if [ $exectype = "commandline" ];

        	then
		echo "Running docker in command line mode"
		sudo docker run -ti  -v $HOME:$HOME -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -e XAUTHORITY=$XAUTH laramaktub/docker-domino /bin/bash

	else

	echo "Wrong input parameter. Correct parameters are: commandline or gui"

	fi

fi
