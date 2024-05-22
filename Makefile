.PHONY:

img:
	mvn clean package -Dmaven.test.skip=true
	docker build -t registry.cn-hangzhou.aliyuncs.com/opensource-sharing/suiteboot-example:v2.0  -f ./Dockerfile.build.from.local  .
	docker push registry.cn-hangzhou.aliyuncs.com/opensource-sharing/suiteboot-example:v2.0

pack:
	mvn clean package -Dmaven.test.skip=true