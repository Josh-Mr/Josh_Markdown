APP=/jenkins/jenkins01-0.0.1-SNAPSHOT
APP_NAME=${APP}".jar"

log_dir=/jenkins
log_file=/jenkins/app.log

command=$1


function start(){

    if [ ! -d "${log_dir}" ];then
        mkdir "${log_dir}"
    fi

    rm -f tpid
    nohup /opt/soft/jdk1.8.0_211/bin/java  -jar ${APP_NAME} -Duser.dir=/jenkins> /jenkins/app.log 2>&1 &
    echo $! > tpid
    check
}


function stop(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [ "${tpid}" ]; then
        echo 'stop process...'
        kill -15 $tpid
    fi

    sleep 5

    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [ "${tpid}" ]; then
        echo 'Kill Process!'
        kill -9 $tpid
    else
        echo 'Stop Success!'
    fi
}


function check(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [ "${tpid}" ]; then
        echo 'App is running.'
    else
        echo 'App is NOT running.'
    fi

}


function forcekill(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`

    if [ "${tpid}" ]; then
        echo 'Kill Process!'
        kill -9 $tpid

    fi

}

function showtpid(){
    tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
    if [ "${tpid}" ]; then
        echo 'process '$APP_NAME' tpid is '$tpid
    else
        echo 'process '$APP_NAME' is not running.'
    fi
}

if [ "${command}" ==  "start" ]; then
    start

elif [ "${command}" ==  "stop" ]; then
     stop

elif [ "${command}" ==  "check" ]; then
     check

elif [ "${command}" ==  "kill" ]; then
     forcekill

elif [ "${command}" == "tpid" ];then
     showtpid

else
    echo "Unknow argument...."
fi
