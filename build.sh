#!/bin/sh
cd $OPENSHIFT_REPO_DIR

export JAVA_HOME=$OPENSHIFT_DATA_DIR/java
export M2_HOME=/etc/alternatives/maven-3.0
export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH


if [ ! -d "${OPENSHIFT_DATA_DIR}maven.xml" ];then
    curl -o ${OPENSHIFT_DATA_DIR}maven.xml -L "https://raw.githubusercontent.com/pkolmykov/jetty-openshift-java8/master/maven.xml"
fi    
mvn --global-settings ${OPENSHIFT_DATA_DIR}maven.xml --version
mvn --global-settings ${OPENSHIFT_DATA_DIR}maven.xml clean package -Popenshift -DskipTests