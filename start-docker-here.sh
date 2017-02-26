#!/bin/bash
PROJECTNAME=ansible-gitlab
CURRENTDIR=$(pwd)

# ansible docker build container
BUILD_CONTAINER=f3rdy/ansible-docker:centos

# clean up prior to start
function cleanup() {
  docker ps | grep " ${1}$" > /dev/null && \
  {
    if [ -z ${2} ]; then
      >&2 echo "Container ${1} already running. Check docker ps." ;
      exit 1 ;
    else
      >&2 echo "Container ${1} already running. Killing and removing:" ;
      docker kill ${1} && docker rm ${1} > /dev/null || \
      {
        >&2 echo "Failed to remove the container ${1}. Exiting." ;
        exit 1 ;
      }
    fi
  }


  docker ps -a | grep " ${1}$" && \
  {
      >&2 echo "Found old container ${1}. Removing." ;
      docker rm ${1} || \
      {
        >&2 echo "Removing of old container failed." ;
        exit 1 ;
      }
      >&2 echo "Cleanup successful." ;
  }
}

cleanup ${PROJECTNAME}

## load artifactory project
echo
echo ">>> start docker container $PROJECTNAME..."
echo
docker pull ${BUILD_CONTAINER}
docker run --name $PROJECTNAME -it --rm \
-v $CURRENTDIR:/root/$PROJECTNAME -w /root/$PROJECTNAME \
${BUILD_CONTAINER} /bin/bash


echo
echo "--- stopped: docker container $PROJECTNAME ---"
echo

## stop postgres
echo
echo ">>> Cleanup..."
echo
cleanup ${PROJECTNAME}
cleanup postgres -f
echo
echo "--- Cleanup done. --"
echo
