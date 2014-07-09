FROM ubuntu

MAINTAINER Inventit Inc.

ENV STORM_VERSION 0.9.2
ENV STORM_HOME /usr/share/apache-storm-$STORM_VERSION-incubating
ENV LOGSTASH_LOGBACK_ENCODER_VERSION 2.8

RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y unzip wget supervisor

# for add-apt-repository, http://stackoverflow.com/a/13018671
RUN apt-get install -y software-properties-common python-software-properties
# Java8 http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Apache Storm
RUN wget -q -N  http://www.us.apache.org/dist/incubator/storm/apache-storm-$STORM_VERSION-incubating/apache-storm-$STORM_VERSION-incubating.zip
RUN unzip -o /apache-storm-$STORM_VERSION-incubating.zip -d /usr/share/; rm apache-storm-$STORM_VERSION-incubating.zip
RUN mkdir /var/log/storm
RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm  

ADD storm.yaml $STORM_HOME/conf/storm.yaml
ADD cluster.xml $STORM_HOME/logback/cluster.xml
ADD config-supervisord.sh /usr/bin/config-supervisord.sh
ADD start-supervisor.sh /usr/bin/start-supervisor.sh 

RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf

# Logstash Logback Encoder
RUN wget -q -N  http://central.maven.org/maven2/net/logstash/logback/logstash-logback-encoder/$LOGSTASH_LOGBACK_ENCODER_VERSION/logstash-logback-encoder-$LOGSTASH_LOGBACK_ENCODER_VERSION.jar
RUN mv /logstash-logback-encoder-$LOGSTASH_LOGBACK_ENCODER_VERSION.jar $STORM_HOME/lib 
