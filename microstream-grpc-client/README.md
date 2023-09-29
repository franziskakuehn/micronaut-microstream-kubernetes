### Client

microstream-grpc-client
- Client asks grpc-server to gather rawdata over gRPC endpoint, stores some aggregates and provides data over gRPC API definition as well
- Client is implemented as server as well for unlimited request possibility

```mn create-app orange.business.jhub.microstream-grpc-client --features=microstream,serialization-jackson,micronaut-validation,grpc --lang=java```

```
./startUpClient
```

```
grpcurl  -d  '{"pageid":"Page_81", "userid":"User_2"}' -plaintext 127.0.0.1:50051 ClickAggService.UserClicksByIdOnPage

grpcurl  -d  '{"pageid":"Page_81"}' -plaintext 127.0.0.1:50051 ClickAggService.PagesCountById

grpcurl  -d  '{"pageid":"Page_81"}' -plaintext 127.0.0.1:50051 ClickAggService.PagesById

grpcurl  -plaintext 127.0.0.1:50051 describe ClickAggService.PagesById

grpcurl  -plaintext 127.0.0.1:50051 describe ClickAggService
```
