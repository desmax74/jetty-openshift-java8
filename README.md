# Jetty Java-8 QuickStart for OpenShift

Even though OpenShift doesn't support java8 for this moment, this tools can help to use java8 with jetty in DIY cartridge

This is improved version of forked jetty-openshift-quickstart project.
In this project was added jdk8 installation and running maven and jetty using this java.

## Installation

Create new DIY application
You can use the web UI or by executing the rhc command like this:

    rhc app create jetty diy-0.1
    
Once the application is created, clone it locally (if not cloned already) and edit the start and stop scripts in the .openshift/action_hooks directory. Then configure POM for using custom java path. See [sample](https://github.com/pkolmykov/jetty-openshift-java8/tree/master/sample).

###Start script (start.sh)
```sh
#!/bin/bash
URL=https://raw.githubusercontent.com/pkolmykov/jetty-openshift-java8/master/

curl -s ${URL}java_setup.sh | bash -s http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz
curl -s ${URL}jetty_setup.sh | bash -s http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.3.v20140905.tar.gz&r=1
curl -s ${URL}build.sh | bash
curl -s ${URL}start.sh | bash
```
####java_setup.sh
Will setup java8. Executed with link from jdk can be downloaded. Modify this link to use latest version.

####jetty_setup.sh
Will setup jetty. Executed with link from jdk can be downloaded. Modify this link to use latest version.

####build.sh
Build script will download maven.xml config file to work with local repository.
Sets up required PATH configurations and environment variables and runs maven to print environment information and build the application using next command:
```sh
mvn clean package -Popenshift -DskipTests
```
####start.sh
Ensures the webapps directory links to our deployments directory with build war file and starts Jetty (using jdk8) binding it to $OPENSHIFT_INTERNAL_IP and $OPENSHIFT_INTERNAL_PORT. Then it saved the PID of the process to pid file to provide information for stop script.

###Stop script (stop.sh)
Stop script just kills the process with previously saved PID.

##Configuring Maven POM file
The main idea is to say maven to use custom path of java compiler
```xml
<properties>
                <maven.compiler.executable>${env.OPENSHIFT_DATA_DIR}java/bin/javac</maven.compiler.executable>
                <maven.compiler.fork>true</maven.compiler.fork>
</properties>
```
See full example [here](https://github.com/pkolmykov/jetty-openshift-java8/blob/master/sample/pom.xml)




