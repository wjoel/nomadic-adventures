job "graylog" {
  datacenters = ["dc1"]
  group "tasks" {
    task "mongodb" {
      driver = "docker"
      config {
        image = "zeus.wjoel.com:5000/nomadic-mongodb:3.2.4"
        port_map {
          mongod = 27017
          mongod_shardsvr = 27018
          mongod_configsvr = 27019
          mongod_web = 28017
        }
      }
      service {
        name = "mongod"
        port = "mongod"
      }
      service {
        name = "mongod-web"
        port = "mongod_web"
      }
      resources {
        cpu = 200
        memory = 256
        network {
          mbits = 10
          port "mongod" {}
          port "mongod_shardsvr" {}
          port "mongod_configsvr" {}
          port "mongod_web" {}
        }
      }
    }
    task "elasticsearch" {
      driver = "docker"
      config {
        image = "zeus.wjoel.com:5000/nomadic-elasticsearch:2.2.1"
        port_map {
          elasticsearch = 9200
          elasticsearch_cluster = 9300
        }
      }
      service {
        name = "elasticsearch"
        port = "elasticsearch"
      }
      service {
        name = "elasticsearch-cluster"
        port = "elasticsearch_cluster"
      }
      resources {
        cpu = 100
        memory = 300
        network {
          mbits = 10
          port "elasticsearch" {}
          port "elasticsearch_cluster" {}
        }
      }
    }
    task "graylog" {
      driver = "docker"
      config {
        image = "zeus.wjoel.com:5000/nomadic-graylog:2.0"
        port_map {
          graylog_web = 9000
          graylog_rest = 12900
          graylog_gelf = 12201
        }
      }
      service {
        name = "graylog"
        port = "graylog_web"
      }
      service {
        name = "graylog-rest"
        port = "graylog_rest"
      }
      service {
        name = "es-transport"
        port = "es_transport"
      }
      resources {
        cpu = 200
        memory = 600
        network {
          mbits = 10
          port "graylog_web" {
            static = 9000
          }
          port "graylog_rest" {}
          port "graylog_gelf" {
            static = 12201
          }
          port "es_transport" {
            # static = 19000
          }
        }
      }
    }
  }
}
