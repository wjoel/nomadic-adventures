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

echo "restart-graylog.sh called"

get_pid() {
    cat "${GRAYLOG_PID}" 2> /dev/null
}

if test -e "$GRAYLOG_PID"; then
    echo "Stopping graylog-server ($PID) ..."
    echo "Waiting for graylog-server to halt."
    kill $PID
    while "$PS" -p $PID > /dev/null; do sleep 1; done;
    rm -f "${GRAYLOG_PID}"
    echo "graylog-server stopped"
fi

"${NOHUP}" "${JAVA_CMD}" ${JAVA_OPTS} ${LOG4J} -jar "${GRAYLOG_SERVER_JAR}" server -f "${GRAYLOG_CONF}" -p "${GRAYLOG_PID}" >> "${LOG_FILE}" 2>> "${LOG_FILE}" &

echo "$(date) graylog-server starting"
