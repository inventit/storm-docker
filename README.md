storm-docker
============

This project is forked from `https://github.com/wurstmeister/storm-docker`.

The differences are

1. Installed software versions
1. LogStash integration
1. Shared data volume container
1. Running as root because of sharing the volume
1. Running with LogStash, Elastic Search and Kibana
1. Boot2docker helper shell
1. Memcached container support

##Usage

Start a cluser:

- ```start-storm.sh```

Destroy a cluster:

- ```destroy-storm.sh```

##Building

- ```rebuild.sh```

Note that LogStash/ElasticSearch/Kibana container is NOT included as it is always downloaded from [Docker-Hub](https://hub.docker.com/).

## Installed Software

1. Apache Storm 0.9.2
1. Oracle JDK 1.8

# Tips
## Boot2docker users

Run `ntpclient` whenever you suspend your machine or boot2docker instance.

    $ sudo ntpclient -s -h time.asia.apple.com

Install `bash.tcz` as `bash` is missing by default.

    $ tce-load -wi bash.tcz

## How to customize

Replace `localhost:5000/inventit` in all the files within this project with your own tag, e.g. `localhost:5000:acme` if you'd like to use your [private registry](http://blog.docker.com/2013/07/how-to-use-your-own-registry/).

Replace `MAINTAINER` value as well.

## How to browse Storm UI

Open `http://HOST:49080` with your browser. The `HOST` will be identified by `boot2docker ip` if you're running Docker on Boot2docker.
`49080` can be changed as it is described in `start-strom.sh`.

The log viewer UI is listening to the port `49000`.

## How to deploy your topology

At first, intstall Apache Storm on your host machine and make sure `storm` command works.

After creating your topology and building it, run the following command.

    storm jar path/to/your/topology.jar fqdn.of.your.TopologyMainClass \
      -c nimbus.host=HOST -c nimbus.thrift.port=49627

The thrift port `49627` can be changed as it is described in `start-strom.sh`.

## How to browse Storm logs with Kibana

Open `http://HOST:9292` and you can see the Kibana dashboard.

## How to use Memcached

The supertvisor node is already linking to the memcached container. You can access the `memcached1` container with the following environment variables from your Spouts, Bolts or Trident States.

1. `MEMCACHED1_PORT_11211_TCP_ADDRESS` for IP address
1. `MEMCACHED1_PORT_11211_TCP_PORT` for TCP port
