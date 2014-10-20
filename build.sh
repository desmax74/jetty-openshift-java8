#!/bin/sh
cd $OPENSHIFT_REPO_DIR

export M2=$OPENSHIFT_DATA_DIR/maven/bin
export MAVEN_OPTS="-Xms384m -Xmx412m"
export JAVA_HOME=$OPENSHIFT_DATA_DIR/java
export PATH=$JAVA_HOME/bin:$M2:$PATH

#mvn -s settings.xml clean install


if [ ! -f "${OPENSHIFT_DATA_DIR}maven.xml" ];then
    curl -o ${OPENSHIFT_DATA_DIR}maven.xml -L "https://raw.githubusercontent.com/pkolmykov/jetty-openshift-java8/master/maven.xml"
fi
mvn -s ${OPENSHIFT_DATA_DIR}maven.xml --version
mvn -s ${OPENSHIFT_DATA_DIR}maven.xml clean install -Popenshift -DskipTests