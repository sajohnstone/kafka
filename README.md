# Kafka

This is an example Kafka instance using the [quick start instructions](https://kafka.apache.org/quickstart)

## Getting started

To build this docker image run the following

```
docker build -t platform/kafka:latest .
```

Once build use the following to run this

```
docker run -p 2181:2181 -p 9092:9092 -d platform/kafka:latest 
```

To test sending and recieving messages you can either use a tool such as [kadmin](https://github.com/BetterCloud/kadmin) or hop onto the docker container and run the following


```
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
> test1
> test2
```

```
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
> test1
> test2
```

## Other 

### Delete images and containers

```
docker rm $(docker ps -a -q) && docker rmi $(docker images -q)
```

### Debug issues

To see what's going on inside a running container you can use 

```
docker exec -i -t [containerid] /bin/bash
```