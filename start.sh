#!/bin/bash

cd velocity

VERSION=${VERSION:-latest}
BUILD=${BUILD:-latest}
MIN_RAM=${MIN_RAM:-256M}
MAX_RAM=${MAX_RAM:-1G}
JAVA_OPTS=${JAVA_OPTS:-"-XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15"}


# Perform initial setup
URL_PREFIX=https://fill.papermc.io/v3/projects/velocity
if [ ${VERSION} = latest ]
  then
    # Get the latest MC version
	VERSION=$(wget -qO - $URL_PREFIX | jq -r '.versions[ (.versions | keys_unsorted | first) ] | first')
fi
URL_PREFIX=${URL_PREFIX}/versions/${VERSION}
if [ ${BUILD} = latest ]
  then
    # Get the latest build
    BUILD=$(wget -qO - $URL_PREFIX/builds/latest | jq -r '.id')
fi

JAR_NAME=velocity-${VERSION}-${BUILD}.jar

if [ ! -e ${JAR_NAME} ]
  then
    rm -f *.jar
	DOWNLOAD_URL=$(wget -qO - $URL_PREFIX/builds/${BUILD} | jq -r '.downloads."server:default".url')
    wget ${DOWNLOAD_URL} -O ${JAR_NAME}
fi

# Execute user command
"$@"

if [ $? -ne 0 ]; then
	exit $?
fi

# Start server
exec java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_OPTS} -jar ${JAR_NAME} nogui
