#!/bin/sh

APP_NAME=suiteboot-example
APP_JAR=suiteboot-example.jar

ENV="$1"

#JVM参数
JVM_OPTS="-Dname=$APP_NAME -Xms1024M -Xmx2048M  -XX:+HeapDumpOnOutOfMemoryError   -XX:NewRatio=1 -XX:SurvivorRatio=30"
BASE_PATH=$(pwd)/suiteboot-example
CONFIG_DIR=$BASE_PATH/config/

if [ "$2" = "" ];
then
    echo -e "\033[0;31m 未输入操作名 \033[0m  \033[0;34m {start|stop|restart|status} \033[0m"
    exit 1
fi

if [ "$APP_NAME" = "" ];
then
    echo -e "\033[0;31m 未输入应用名 \033[0m"
    exit 1
fi

function start()
{
  PID=`ps -ef |grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'`

	if [ x"$PID" != x"" ]; then
	    echo "$APP_NAME is running..."
	else
		$JAVA_HOME/bin/java   \
		-Dotel.instrumentation.common.default-enabled=false \
    -Dotel.instrumentation.opentelemetry-api.enabled=true \
    -Dotel.java.global-autoconfigure.enabled=true \
    -Dotel.instrumentation.elasticsearch.enabled=false \
    -Dotel.service.name=suiteboot-example \
    -DprojectBasePath=$BASE_PATH \
    -Dspring.profiles.active=$ENV $JVM_OPTS \
    -jar  $BASE_PATH/$APP_JAR  \
		--spring.config.location=$CONFIG_DIR
	fi
}

function stop()
{
    echo "Stop $APP_NAME"

	PID=""
	query(){
		PID=`ps -ef |grep java|grep $APP_NAME|grep -v grep|awk '{print $2}'`
	}

	query
	if [ x"$PID" != x"" ]; then
		kill -TERM $PID
		echo "$APP_NAME (pid:$PID) exiting..."
		while [ x"$PID" != x"" ]
		do
			sleep 1
			query
		done
		echo "$APP_NAME exited."
	else
		echo "$APP_NAME already stopped."
	fi
}

function restart()
{
    stop
    sleep 2
    start
}

function status()
{
    PID=`ps -ef |grep java|grep $APP_NAME|grep -v grep|wc -l`
    if [ $PID != 0 ];then
        echo "$APP_NAME   "
    else
        echo "$APP_NAME is not running..."
    fi
}

case $2 in
    start)
    start;;
    stop)
    stop;;
    restart)
    restart;;
    status)
    status;;
    *)

esac
