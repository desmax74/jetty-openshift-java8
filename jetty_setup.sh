#!/bin/sh
#http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.3.v20140905.tar.gz&r=1
if [[ -z "$1" ]];then
    echo "Usage: jetty_setup.sh [URL]"
    exit -1
  else URL=$1
fi

cd ${OPENSHIFT_DATA_DIR:=$HOME}

if [ -d "jetty" ] && [ "`cat jetty/URL`" == $URL ]; then

  echo "Jetty already installed"

else

  echo "Installing Jetty from ${URL}"

  if [ -d "jetty" ]; then
    rm -rf jetty
  fi

  wget -O jetty.tar.gz ${URL}
  
  mkdir jetty
  tar -xf jetty.tar.gz -C jetty --strip-components=1

  rm jetty.tar.gz

  echo $URL > jetty/URL

  rm -rf jetty/contexts/*
  rm -rf jetty/webapps


fi