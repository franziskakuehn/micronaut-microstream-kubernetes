### Server

microstream-grpc-server

  ```mn create-app orange.business.jhub.microstream-grpc-server --features=microstream,serialization-jackson,micronaut-validation,grpc,kafka --build=maven --lang=java ```
  
    - Microservice stores ingested raw data from Kafka topic into Microstream
    - Micronaut application along with Microstream definìtion
    - Micronaut application along with gRPC server provisioning
    - asks the server sth:

```
./portforwardServer.sh
```
```
grpcurl -d  '{"pageid":"Page_81", "userid":"User_2"}' -plaintext 127.0.0.1:5050 ClickService.UserClicksByIdOnPage

grpcurl  -d  '{"pageid":"Page_79"}' -plaintext 127.0.0.1:5050 ClickService.PagesCountById

grpcurl  -d  '{"pageid":"Page_79"}' -plaintext 127.0.0.1:5050 ClickService.PagesById

grpcurl  -plaintext 127.0.0.1:5050 describe ClickService.PagesById

grpcurl  -plaintext 127.0.0.1:5050 describe ClickService
```
