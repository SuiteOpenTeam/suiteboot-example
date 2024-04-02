FROM registry.cn-hangzhou.aliyuncs.com/opensource-sharing/suiteboot-builder:1.0 AS builder
WORKDIR /app
COPY ./ ./
RUN rm -rf ./target && mvn --settings ./settings.xml clean package -Dmaven.test.skip=true

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/suiteboot-example.tar.gz ./suiteboot-example.tar.gz
RUN tar -zxvf ./suiteboot-example.tar.gz
CMD [ "sleep", "1h"]