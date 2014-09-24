#!/bin/sh

URL="http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.3.v20140905.tar.gz"

cd ${OPENSHIFT_DATA_DIR:="~"}

if [ -d "jetty" ] && [ "`cat jetty/URL`" == $URL ]; then

  echo "Jetty already installed"

else

  echo "Installing Jetty from ${URL}"

  if [ -d "jetty" ]; then
    rm -rf jetty
  fi

  wget -O jetty.tar.gz ${URL}

  tar -xf jetty.tar.gz -C jetty --strip-components=1

  rm jetty.tar.gz

  echo $URL > jetty/URL

  rm -rf jetty/contexts/*
  rm -rf jetty/webapps

  curl -o maven.xml -L "https://raw.githubusercontent.com/pkolmykov/jetty-openshift-java8/master/maven.xml"

fi
