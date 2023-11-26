#!/bin/bash

cd velocity

VERSION=${VERSION:-latest}
BUILD=${BUILD:-latest}
MIN_RAM=${MIN_RAM:-256M}
MAX_RAM=${MAX_RAM:-1G}


# Perform initial setup
URL_PREFIX=https://papermc.io/api/v2/projects/velocity
if [ ${VERSION} = latest ]
  then
    # Get the latest MC version
    VERSION=$(wget -qO - $URL_PREFIX | jq -r '.versions[-1]') # "-r" is needed because the output has quotes otherwise
fi
URL_PREFIX=${URL_PREFIX}/versions/${VERSION}
if [ ${BUILD} = latest ]
  then
    # Get the latest build
    BUILD=$(wget -qO - $URL_PREFIX | jq '.builds[-1]')
fi

JAR_NAME=velocity-${VERSION}-${BUILD}.jar

if [ ! -e ${JAR_NAME} ]
  then
    rm -f *.jar
    wget ${URL_PREFIX}/builds/${BUILD}/downloads/velocity-${VERSION}-${BUILD}.jar -O ${JAR_NAME}
    if [ ! -e eula.txt ]
    then
      java -jar ${JAR_NAME}
      sed -i 's/false/true/g' eula.txt
    fi
fi

# Start server
exec java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_OPTS} -jar ${JAR_NAME} nogui
