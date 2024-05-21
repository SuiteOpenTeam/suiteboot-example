FROM golang:1.21 as build
ARG  OTEL_VERSION=0.96.0
WORKDIR /go
ENV GOPATH /go
COPY . .
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go install go.opentelemetry.io/collector/cmd/builder@v${OTEL_VERSION}
RUN CGO_ENABLED=0 builder --config=custom_collector_define.yaml

FROM gcr.io/distroless/base-debian11
COPY --from=build /go/ocb_builder/collector /
COPY otelcol-contrib-config.yaml /etc/otelcol-contrib-config.yaml
EXPOSE 4317/tcp
CMD ["--config", "/etc/otelcol-contrib-config.yaml"]
ENTRYPOINT ["/collector"]