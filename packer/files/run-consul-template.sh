#!/bin/sh

/opt/bin/consul-template \
    -consul 192.168.111.111:8500 \
    -template "/etc/graylog.conf.tmpl:/alloc/graylog.conf:/usr/bin/stop-graylog.sh" \
    -template "/etc/elasticsearch.yml.tmpl:/alloc/elasticsearch.yml:/usr/bin/stop-graylog.sh"
