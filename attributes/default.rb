# #-*- encoding : utf-8 -*-
# === VERSION AND LOCATION
default.elasticsearch[:version]       = "1.5.2"
default.elasticsearch[:host]          = "http://download.elasticsearch.org"
default.elasticsearch[:repository]    = "elasticsearch/elasticsearch"
default.elasticsearch[:filename]      = "elasticsearch-#{node.elasticsearch[:version]}.tar.gz"
default.elasticsearch[:download_url]  = [node.elasticsearch[:host], node.elasticsearch[:repository], node.elasticsearch[:filename]].join('/')

# === USER & PATHS
default.elasticsearch[:dir]       = "/data"
default.elasticsearch[:user]      = "elasticsearch"
default.elasticsearch[:home_dir]  = [node.elasticsearch[:dir], node.elasticsearch[:user]].join('/')
default.elasticsearch[:version_dir] = "#{node[:elasticsearch][:home_dir]}-#{node[:elasticsearch][:version]}"
default.elasticsearch[:command_path]  = [node.elasticsearch[:home_dir], 'bin', 'elasticsearch'].join('/')

default.elasticsearch[:path][:conf] = [node.elasticsearch[:version_dir], "config"].join('/')
default.elasticsearch[:path][:data] = [node.elasticsearch[:version_dir], "data"].join('/')
default.elasticsearch[:path][:plugins] = [node.elasticsearch[:version_dir], "plugins"].join('/')
default.elasticsearch[:path][:logs] = ['/var/log',node.elasticsearch[:user]].join('/')
default.elasticsearch[:path][:pids] = '/var/run'
default.elasticsearch[:pid_file]  = [node.elasticsearch[:path][:pids], "elasticsearch.pid"].join('/')

# === MEMORY
# Use half of memory for heap but no more than magical limit.
# https://www.elastic.co/guide/en/elasticsearch/guide/current/_limiting_memory_usage.html
# https://www.elastic.co/guide/en/elasticsearch/guide/current/heap-sizing.html
half_memory_mb = ((node.memory.total.to_i * 0.5 ).floor / 1024).floor
default.elasticsearch[:allocated_memory] = "#{[half_memory_mb, 30500].min}m"

default.elasticsearch[:thread_stack_size] = "256k"

# === CLUSTER
default.elasticsearch[:cluster][:name] = 'elasticsearch'

# === NODE
default.elasticsearch[:node][:name] = nil

default.elasticsearch[:node][:master] = 'true'
default.elasticsearch[:node][:data] = 'true'

# === NETWORK
default.elasticsearch[:network][:bind_host] = nil
default.elasticsearch[:network][:publish_host] = nil
default.elasticsearch[:network][:host] = nil

# === DISCOVERY
default.elasticsearch[:discovery][:zen][:minimum_master_nodes] = nil # Use default of 1.

instances = node[:opsworks][:layers][:elasticsearch][:instances]
hosts = instances.map { |name, attrs| attrs['private_ip'] }
default.elasticsearch[:discovery][:zen][:ping][:unicast][:hosts] = hosts
