#!/bin/sh

GRAYLOG_CONF=/alloc/graylog.conf
LOG_FILE=/alloc/logs/graylog-server.log

NOHUP=${NOHUP:=$(which nohup)}
PS=${PS:=$(which ps)}
JAVA_CMD=${JAVA_CMD:=$(which java)}
GRAYLOG_DIR=/opt/graylog-2.0.0-beta.1
GRAYLOG_SERVER_JAR=${GRAYLOG_SERVER_JAR:=$GRAYLOG_DIR/graylog.jar}
GRAYLOG_CONF=${GRAYLOG_CONF:=/etc/graylog/server/server.conf}
GRAYLOG_PID=${GRAYLOG_PID:=/tmp/graylog.pid}
LOG_FILE=${LOG_FILE:=log/graylog-server.log}
LOG4J=${LOG4J:=}
DEFAULT_JAVA_OPTS="-Djava.library.path=${GRAYLOG_DIR}/lib/sigar -Xms512m -Xmx512m -XX:NewRatio=1 -server -XX:+ResizeTLAB -XX:+UseConcMarkSweepGC -XX:+CMSConcurrentMTEnabled -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:-OmitStackTraceInFastThrow"
JAVA_OPTS="${JAVA_OPTS:="$DEFAULT_JAVA_OPTS"}"

"${NOHUP}" "${JAVA_CMD}" ${JAVA_OPTS} ${LOG4J} -jar "${GRAYLOG_SERVER_JAR}" server -f "${GRAYLOG_CONF}" -p "${GRAYLOG_PID}" >> "${LOG_FILE}" 2>> "${LOG_FILE}"
