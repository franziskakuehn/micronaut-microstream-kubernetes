package orange.business.jhub.s3;

import io.micronaut.context.annotation.ConfigurationBuilder;
import io.micronaut.context.annotation.ConfigurationProperties;

@ConfigurationProperties("aws")
// @Requires(property = "s3.test", value = StringUtils.TRUE)
class S3MinioConfig extends S3ConfigurationProperties {
    @ConfigurationBuilder(configurationPrefix = "services.s3")
    S3Configuration s3 = new S3Configuration();

    @Override
    public S3Configuration getS3Configuration() {
        return this.s3;
    }
}
