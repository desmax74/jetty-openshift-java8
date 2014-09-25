#!/bin/sh
#http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz

if [[ -z "$1" ]];then
    echo "Usage: java_setup.sh [URL]"
    exit -1
  else URL=$1
fi

cd $OPENSHIFT_DATA_DIR

if [ -d "java" ] && [ "`cat java/URL`" == ${URL} ]; then

  echo "Java already installed"

else

  echo "Installing Java from ${URL}"

  if [ -d "java" ]; then
    rm -rf java
  fi

  wget --progress=bar -O java.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${URL}

  mkdir java
  tar -xf java.tar.gz -C java --strip-components=1
  rm java.tar.gz

  echo ${URL} > java/URL

fi

