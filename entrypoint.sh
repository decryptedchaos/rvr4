#!/bin/bash
sleep 2

#Install the Server

if [[ -f /home/container/preflight.sh ]]; then
	/home/container/preflight.sh
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo "~/server: ${MODIFIED_STARTUP}"

# Create some folders per the linux install guide
mkdir -p /home/container/.local/share/Arma\ 3 && mkdir -p /home/container/.local/share/Arma\ 3\ -\ Other\ Profiles

cd /home/container/server

# Create symlink for MPMissions to solve random segfaults
mkdir -p /home/container/server/MPMissions


# $NSS_WRAPPER_PASSWD and $NSS_WRAPPER_GROUP have been set by the Dockerfile
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /passwd.template > ${NSS_WRAPPER_PASSWD}
export LD_PRELOAD=/libnss_wrapper.so

# Run the Server
${MODIFIED_STARTUP}

if [ $? -ne 0 ]; then
    echo "PTDL_CONTAINER_ERR: There was an error while attempting to run the start command."
    exit 1
fi
