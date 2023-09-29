package orange.business.jhub.s3;

import java.net.URISyntaxException;

import io.micronaut.context.annotation.Factory;
import io.micronaut.context.annotation.Replaces;
import jakarta.inject.Singleton;
import software.amazon.awssdk.services.s3.S3Client;

@Factory
// @Requires(property = "s3.test", value = StringUtils.TRUE)
public class S3MinioClient {

    @Singleton
    @Replaces(S3Client.class)
    S3Client buildClient(S3MinioConfig s3Config) throws URISyntaxException {
        return MinioUtils.s3Client(s3Config);
    }
}