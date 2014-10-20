#!/bin/sh
#http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.3.v20140905.tar.gz&r=1
if [[ -z "$1" ]];then
    echo "Usage: maven_setup.sh [URL]"
    exit -1
  else URL=$1
fi

cd ${OPENSHIFT_DATA_DIR:=$HOME}

if [ -d "maven" ] && [ "`cat maven/URL`" == $URL ]; then

  echo "Maven already installed"

else

  echo "Installing Maven from ${URL}"

  if [ -d "maven" ]; then
    rm -rf maven
  fi

  wget -O maven.tar.gz ${URL}

  mkdir maven
  tar -xf maven.tar.gz -C maven --strip-components=1

  rm maven.tar.gz

  echo $URL > maven/URL


fi