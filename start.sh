#!/bin/bash

cd velocity

MC_VERSION=${1:-latest}
VELOCITY_BUILD=${2:-latest}
MC_RAM=${3:-1G}


# Perform initial setup
URL_PREFIX=https://papermc.io/api/v2/projects/velocity
if [ ${MC_VERSION} = latest ]
  then
    # Get the latest MC version
    MC_VERSION=$(wget -qO - $URL_PREFIX | jq -r '.versions[-1]') # "-r" is needed because the output has quotes otherwise
fi
URL_PREFIX=${URL_PREFIX}/versions/${MC_VERSION}
if [ ${VELOCITY_BUILD} = latest ]
  then
    # Get the latest build
    VELOCITY_BUILD=$(wget -qO - $URL_PREFIX | jq '.builds[-1]')
fi

JAR_NAME=velocity-${MC_VERSION}-${VELOCITY_BUILD}.jar

if [ ! -e ${JAR_NAME} ]
  then
    rm -f *.jar
    wget ${URL_PREFIX}/builds/${VELOCITY_BUILD}/downloads/velocity-${MC_VERSION}-${VELOCITY_BUILD}.jar -O ${JAR_NAME}
    if [ ! -e eula.txt ]
    then
      java -jar ${JAR_NAME}
      sed -i 's/false/true/g' eula.txt
    fi
fi

# Start server
exec java -server -Xms${MC_RAM} -Xmx${MC_RAM} ${JAVA_OPTS} -jar ${JAR_NAME} nogui
