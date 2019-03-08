FROM ubuntu:16.04
LABEL author=sjohnstone

# Install section
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install supervisor -y
RUN apt-get -y install wget
RUN apt-get -y install openjdk-8-jre

RUN wget http://apache.mirror.anlx.net/kafka/2.1.0/kafka_2.11-2.1.0.tgz 
RUN tar -xzf kafka_2.11-2.1.0.tgz

WORKDIR /kafka_2.11-2.1.0/

# Configure supervisor (enables you to start two processes)
RUN echo "[supervisord]" > /etc/supervisord.conf && \
    echo "nodaemon=true" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf && \
    echo "[program:zookeeper]" >> /etc/supervisord.conf && \
    echo "command=/kafka_2.11-2.1.0/bin/zookeeper-server-start.sh /kafka_2.11-2.1.0/config/zookeeper.properties" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf && \
    echo "[program:kafka]" >> /etc/supervisord.conf && \
    echo "command=/kafka_2.11-2.1.0/bin/kafka-server-start.sh /kafka_2.11-2.1.0/config/server.properties" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf

# Load container
CMD ["/usr/bin/supervisord"]