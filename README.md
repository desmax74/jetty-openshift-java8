# Jetty Java8 QuickStart for OpenShift

Even though OpenShift doesn't support java8 for this moment, this tools can help to use java8 with jetty in DIY cartridge

This is improved version of forked jetty-openshift-quickstart project.
In this project was added jdk8 installation and running maven and jetty using this java.

## Installation

Create new DIY application
You can use the web UI or by executing the rhc command like this:

    rhc app create jetty diy-0.1
    
Once the application is created, clone it locally (if not cloned already) and edit the start and stop scripts in the .openshift/action_hooks directory. Then configure POM for using custom java path.

###Start script (start.sh)
```sh
#!/bin/bash
URL=https://raw.githubusercontent.com/pkolmykov/jetty-openshift-java8/master/

curl -s ${URL}java_setup.sh | bash -s http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz
curl -s ${URL}jetty_setup.sh | bash -s http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.3.v20140905.tar.gz&r=1
curl -s ${URL}build.sh | bash
curl -s ${URL}start.sh | bash
```



