## Feature http-client documentation

- [Micronaut HTTP Client documentation](https://docs.micronaut.io/latest/guide/index.html#httpClient)

## Feature microstream documentation

- [Micronaut MicroStream documentation](https://micronaut-projects.github.io/micronaut-microstream/latest/guide)

- [https://microstream.one/](https://microstream.one/)

## gRPC

- [Introduction](https://grpc.io/docs/what-is-grpc/introduction/)
- [Core concept](https://grpc.io/docs/what-is-grpc/core-concepts/)
- [tutorials](https://grpc.io/docs/languages/java/)
- [basictutorial in bitbucket](https://grpc.io/docs/languages/java/basics/)
- git clone ssh://git@git02.unbelievable-machine.net:7999/jav/simplegrpcbasictutorial.git


- for eventhandling- simplest rpc call is implemented.
  > simple RPC (one of 4 service methods of RPC)
  > A simple RPC where the client sends a request to
  > the server using the stub and waits for a response to come back, just like a normal function call.


  > A server-side streaming RPC (one of 4 service methods of RPC)
  > the client sends a request to the server and gets a stream to read a sequence of messages back.
  > The client reads from the returned stream until there are no more messages.

  ### multi-module gradle

- jhub-grpc-stack
- microstream-grpc-client
- microstream-grpc-server

### kubernetes setup

- Deploys object storage with MiniIo into lokal Kubernetes
- Deploys Kafka Confluent Platform into local Kubernetes with Confluent Kubernetes Operator
    - Kafka broker
    - Zookeeper
    - Schemaregistry
    - Connect with Datagen Connector
    - Topic
    - RestClass
- Server reads from Kafka and stores into S3
- Client reads from server and stores into S3
- ConfigFiles in kubernetes_setup
- MiniIo-WebUI can be accessed over localhost:9000 with port-forwarding
- Controlcenter-WebUI can be accessed over localhost:9021 with port-forwarding

```
JHUB_NAMESPACE=JHUB ./setupKubernetes
```

#### IPConfig
jhub-grpc-stack
```
MinioUtils.java

.endpointOverride(new URI("http://10.1.1.1:9000/"))

```
microstream-grpc-server
```
application.yml

kafka:
  bootstrap:
    servers: 10.1.0.214:9092
```
microstream-grpc-client
```
application.yml

my:
  server: 10.1.0.220
  port: 5050
```

```
./portforward_controlcenter.sh
```

```
./portforwardmio.sh
```



