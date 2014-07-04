storm-docker
============

Dockerfiles for building a storm cluster. Inspired by [https://github.com/ptgoetz/storm-vagrant](https://github.com/ptgoetz/storm-vagrant)

The images are available directly from [https://index.docker.io](https://index.docker.io)

##Usage

Start a cluser:

- ```start-storm.sh```

Destroy a cluster:

- ```destroy-storm.sh```

##Building

- ```rebuild.sh```

## Installed Software

1. Apache Storm 0.9.2
1. Oracle JDK 1.8

# Tips
## Boot2docker users

Install `bash.tcz` with `tce-ab` command as `bash` is missing by default.

## How to customize

Replace `localhost:5000/inventit` in all the files within this project with your own tag, e.g. `localhost:5000:acme` if you'd like to use your [private registry](http://blog.docker.com/2013/07/how-to-use-your-own-registry/).

Replace `MAINTAINER` value as well.

## How to browse Storm UI

Open `http://HOST:49080` with your browser. The `HOST` will be identified `boot2docker ip` if you're running Docker on Boot2docker.
`49080` is can be changed as it is described in `start-strom.sh`.

The log viewer UI is listening to the port `49000`.

## How to deploy your topology

At first, intstall Apache Storm on your host machine and make sure `storm` command works.

After creating your topology and building it, run the following command.

    storm jar path/to/your/topology.jar fqdn.of.your.TopologyMainClass -c nimbus.host=HOST -c nimbus.thrift.port=49627

`49627` is can be changed as it is described in `start-strom.sh`.

