#!/bin/bash
# VARIABLES
GAME_DIR="/appdata/sapiens/server"

echo "-------------------------------INSTALL & UPDATE------------------------------"
/usr/games/steamcmd +force_install_dir ${GAME_DIR} +login anonymous +app_update 2886350 +quit

echo "----------------------------------START GAME---------------------------------"
cd ${GAME_DIR}

WORLD_COUNT=$(./linuxServer -l | grep "${WORLD_NAME}" | wc -l)

if [ "${WORLD_COUNT}" -gt "0" ]; then 
  echo "World found, loading"
  ./linuxServer -o "${WORLD_NAME}" ${ARG_DEBUG} ${ARG_ADVERTISE} ${ARG_SERVER_ID} ${ARG_PORT} ${ARG_HTTP}
else
  echo "World not found, creating"
  ./linuxServer -n "${WORLD_NAME}" -s "${WORLD_SEED}" ${ARG_DEBUG} ${ARG_ADVERTISE} ${ARG_SERVER_ID} ${ARG_PORT} ${ARG_HTTP}
fi

echo "-----------------------------------END GAME----------------------------------"
sleep 1
echo "-----------------------------------BYE !!!!----------------------------------"