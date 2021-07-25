#!/bin/bash
docker run --rm -ti --net=host -v ${PWD}:/home/pi/Workspace -w /home/pi/Workspace pizawad/raspios-lite /bin/bash

