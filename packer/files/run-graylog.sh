#!/bin/sh

sleep 30

/opt/bin/consul-template -consul 192.168.111.111:8500 -template "/etc/elasticsearch.yml.tmpl:/alloc/elasticsearch.yml" -once

/opt/bin/consul-template -consul 192.168.111.111:8500 -template "/etc/graylog.conf.tmpl:/alloc/graylog.conf" -once

/usr/bin/restart-graylog.sh

/opt/bin/consul-template -consul 192.168.111.111:8500 -template "/etc/graylog.conf.tmpl:/alloc/graylog.conf:/usr/bin/restart-graylog.sh"
