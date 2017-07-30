#!/bin/bash
sleep 4
#Install the Server
if [[ -f /home/container/steam_appid.txt ]] || [[ ${UPDATE} == "1" ]]; then
	./home/container/steamcmd/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${APP_ID} validate +quit
fi

if [[ -f /home/container/preflight.sh ]]; then
	/home/container/preflight.sh
fi
 cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

echo "~/server: ${MODIFIED_STARTUP}"

# Run the Server
${MODIFIED_STARTUP}

if [ $? -ne 0 ]; then
    echo "PTDL_CONTAINER_ERR: There was an error while attempting to run the start command."
    exit 1
fi