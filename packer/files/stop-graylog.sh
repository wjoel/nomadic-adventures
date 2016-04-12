#!/bin/sh

GRAYLOG_PID=/tmp/graylog.pi
PS=${PS:=$(which ps)}
if test -e "$GRAYLOG_PID"; then
    PID=$(cat ${GRAYLOG_PID} 2>/dev/null)
    echo "Stopping graylog-server ($PID) ..."
    echo "Waiting for graylog-server to halt."
    kill $PID
    while "$PS" -p $PID > /dev/null; do sleep 1; done;
    rm -f "${GRAYLOG_PID}"
    echo "graylog-server stopped"
fi
