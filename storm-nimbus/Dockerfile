FROM localhost:5000/inventit/storm
MAINTAINER Inventit Inc.

RUN /usr/bin/config-supervisord.sh nimbus 
RUN /usr/bin/config-supervisord.sh drpc

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773
ADD start-supervisor.sh /usr/bin/start-supervisor.sh
CMD /usr/bin/start-supervisor.sh
