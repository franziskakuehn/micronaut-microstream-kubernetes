plugins {
    // Apply the foojay-resolver plugin to allow automatic download of JDKs
    // id("org.gradle.toolchains.foojay-resolver-convention") version "0.4.0"
    id("io.micronaut.application") version "4.0.0-M4" apply false
    id("java")
    id("com.github.johnrengelman.shadow") version "8.1.1"

}

repositories {
    mavenCentral()
    gradlePluginPortal()
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(20))
    }
}
