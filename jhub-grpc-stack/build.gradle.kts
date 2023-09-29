import com.google.protobuf.gradle.*

plugins {
  id("java")
  id("idea")
  id("com.google.protobuf") version "0.9.2"
  id("io.micronaut.application")

}

repositories {
  mavenCentral()
}

dependencies {
  // implementation("com.google.protobuf:protobuf-java")
  implementation("io.grpc:grpc-stub")
  implementation("io.grpc:grpc-protobuf")
  implementation("software.amazon.awssdk:s3")
  implementation("io.micronaut.aws:micronaut-aws-sdk-v2")
  implementation("one.microstream:microstream-afs-aws-s3")

  if (JavaVersion.current().isJava9Compatible()) {
    // Workaround for @javax.annotation.Generated
    // see: https://github.com/grpc/grpc-java/issues/3633
    implementation("javax.annotation:javax.annotation-api:1.3.2")
  }
}

protobuf {
  protoc {
    // The artifact spec for the Protobuf Compiler
    artifact = "com.google.protobuf:protoc:3.24.3"
  }
  plugins {
    // Optional: an artifact spec for a protoc plugin, with "grpc" as
    // the identifier, which can be referred to in the "plugins"
    // container of the "generateProtoTasks" closure.
    id("grpc") {
      artifact = "io.grpc:protoc-gen-grpc-java:1.58.0"
    }
  }
  generateProtoTasks {
    ofSourceSet("main").forEach {
      it.plugins {
        // Apply the "grpc" plugin whose spec is defined above, without
        // options. Note the braces cannot be omitted, otherwise the
        // plugin will not be added. This is because of the implicit way
        // NamedDomainObjectContainer binds the methods.
        id("grpc") { }
      }
    }
  }
}
