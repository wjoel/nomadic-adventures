#!/bin/sh

ELASTICSEARCH_VERSION=2.2.1

LOG_DIR=/alloc/logs
CONF_DIR=/etc/elasticsearch
HOME_DIR=/var/lib/elasticsearch
DATA_DIR=$HOME_DIR/data
SCRIPT_DIR=$HOME_DIR/scripts
PLUGINS_DIR=$HOME_DIR/plugins
WORK_DIR=/var/tmp/elasticsearch

/usr/bin/java -Xms256m -Xmx256m -Djava.awt.headless=true \
  -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 \
  -XX:+UseCMSInitiatingOccupancyOnly -XX:+PrintGCDetails -XX:+PrintGCTimeStamps \
  -XX:+PrintGCDateStamps -XX:+PrintClassHistogram -XX:+PrintTenuringDistribution \
  -XX:+PrintGCApplicationStoppedTime -Xloggc:$LOG_DIR/elasticsearch-gc.log \
  -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -Dfile.encoding=UTF-8 \
  -Djna.nosys=true \
  -Des.path.home=$HOME_DIR \
  -Dpath.home=/var/lib/elasticsearch \
  -cp /usr/share/java/elasticsearch/lib/elasticsearch-$ELASTICSEARCH_VERSION.jar:/usr/share/java/elasticsearch/lib/* \
  org.elasticsearch.bootstrap.Elasticsearch start \
  -Des.pidfile=/var/run/elasticsearch/elasticsearch.pid \
  -Des.default.path.home=$HOME_DIR \
  -Des.default.path.logs=$LOG_DIR \
  -Des.default.path.data=$DATA_DIR \
  -Des.default.path.conf=$CONF_DIR \
  -Des.default.path.scripts=$SCRIPT_DIR \
  -Des.default.path.work=$WORK_DIR \
  -Des.default.path.plugins=$PLUGINS_DIR \
  -Des.cluster.name=graylog_cluster \
  -Des.network.host=_site_ \
  -Des.http.enabled=false
