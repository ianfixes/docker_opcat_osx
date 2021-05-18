#!/bin/bash

# Start socat, which will be our connection to XQuartz

if ! which Xquartz ; then
  echo Xquartz doesnt seem to be installed
  exit 1
fi

echo Starting socat
trap 'kill $SOCAT_PID; exit' INT
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
SOCAT_PID=$?
sleep 1

if ! pgrep -i xquartz ; then
  echo Starting Xquartz
  open -a /Applications/Utilities/XQuartz.app

  while ! pgrep -i xquartz ; do
    echo Waiting for Xquartz launch
    sleep 3
  done
fi

docker run --rm -it \
  -e DISPLAY=host.docker.internal:0.0 \
  -e USER=${USER} \
  -e HOME=/Users/${USER} \
  --volume /Users/${USER}/Documents:/documents \
  -u $(id -u ${USER}):$(id -g ${USER}) \
  ianfixes/opcat:latest

echo Terminating socat pid $SOCAT_PID
kill $SOCAT_PID
