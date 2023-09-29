### gRPC stack and S3Utils

jhub-grpc-stack
- ./gradlew clean build
- contains the gRPC protobuf definition for
    - message type definition
    - service definition for eventhandling
- Gradle definition for class generation out of protobuf-grpc definition
- generated gRPC classes
    - ServiceBaseDefinitions ( `ClickServiceGrpc.ClickServiceImplBase` ) (gRPC-server)
    - with generated service implementation out of protobuf definition
     `ClickServiceGrpc.ClickServiceImplBase`

        `public void pagesById(orange.business.jhub.PageIdRequest request, io.grpc.stub.StreamObserver<orange.business.jhub.PageView> responseObserver)`

        `public void userClicksByIdOnPage(orange.business.jhub.UserOnPageRequest request,io.grpc.stub.StreamObserver<orange.business.jhub.PageView> responseObserver)`

        > On the server side, the server implements the methods declared by the service and
        > runs a gRPC server to handle client calls.
    - generated synchronous and asynchronous Stub implementation (gRPC-client)

        ```ClickServiceGrpc.ClickServiceBlockingStub```

        or 

        ```ClickServiceGrpc.ClickServiceStub```

        ```public orange.business.jhub.PageIdCountResponse pagesCountById(orange.business.jhub.PageIdRequest request)```

        ```public java.util.Iterator<orange.business.jhub.PageView> pagesById(orange.business.jhub.PageIdRequest request)```
        > On the client side, the client has a local object known as stub that implements the same methods
        > as the service. The methods wrap the parameters for the call in the appropriate protocol buffer
        > message type, send the requests to the server, and return the server’s protocol buffer responses        - 