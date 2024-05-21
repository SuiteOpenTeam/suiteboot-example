# Collector镜像构建

1. 必要条件1 克隆https://github.com/cloudtechstack/opentelemetry-collector-contrib到当前目录下
2. 必要条件2 需要给docker设置梯子，使得可以将gcr.io/distroless/base-debian11镜像下载到本地
3. 这里必须提供go-1.21版本的容器进行编译collector二进制，禁止在自己本地编译collector，否则会造成二进制无法在其他平台上使用