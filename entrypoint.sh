#!/bin/bash
sleep 4
#Install the Server
if [[ ! -f /home/container/steam_appid.txt ]] || [[ ${UPDATE} == "1" ]]; then
	if [[ -f /home/container/steam.txt ]]; then
		/home/container/steamcmd/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${APP_ID} validate +runscript /home/container/steam.txt
	else
		/home/container/steamcmd/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} +force_install_dir /home/container +app_update ${APP_ID} validate +quit
	fi
fi

if [[ -f /home/container/preflight.sh ]]; then
	/home/container/preflight.sh
fi
 
echo "ok back to basics, directly start the server no injection"

cd /home/container

ls -lh

pwd

whoami

./argoserver -netlog -ip=0.0.0.0  -cfg=./cfg/network.cfg -config=./cfg/server.cfg