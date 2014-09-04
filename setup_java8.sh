#!/bin/sh

JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz"

cd $OPENSHIFT_DATA_DIR

if [ -d "java" ] && [ "`cat java/VERSION`" == JAVA_URL ]; then

  echo "Java already installed"

else

  echo "Installing Java from ${JAVA_URL}"

  if [ -d "java" ]; then
    rm -rf java
  fi

  wget -O java.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JAVA_URL}

  mkdir java
  tar -xf java.tar.gz -C java --strip-components=1
  rm java.tar.gz

#  mv jetty-distribution-${JETTY_VERSION} jetty

  echo $JAVA_URL > java/URL

#  rm -rf jetty/contexts/*
#  rm -rf jetty/webapps
#
#  curl -o maven.xml -L "https://raw.githubusercontent.com/pkolmykov/jetty-openshift-java8/master/maven.xml"

fi

