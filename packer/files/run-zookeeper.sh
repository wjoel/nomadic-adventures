#!/bin/bash

CP=/etc/zookeeper:/usr/share/java/slf4j-log4j12.jar:/usr/share/java/slf4j-api.jar:/usr/share/java/netty.jar:/usr/share/java/log4j.jar:/usr/share/java/jline.jar:/usr/share/java/zookeeper.jar
cd /var/lib/zookeeper
/usr/bin/java -cp $CP org.apache.zookeeper.server.quorum.QuorumPeerMain /etc/zookeeper/conf/zoo.cfg
