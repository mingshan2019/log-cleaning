#!/bin/bash

logPath=~/jrkeystone/logs

target_logs=`find ${logpath} -name "*.log.*" -mtime +7`
disk_usage=$(df -h|grep "/$"|awk '{print int($5)}')
if [ $disk_usage -gt 20 ]; then
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        startString="--------------------${curTime} daily log cleaning work started!------------------------------"
        echo $startString >> ${logPath}/logcleaning.txt
        for i in $target_logs
                do
                rm -rf ${logPath}/$i
                deleteTime=$(date '+%Y-%m-%d %H:%M:%S')

                echo "$deleteTime log file $i was deleted." >> ${logPath}/logcleaning.txt
                done;
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        finishString="---------------------${curTime} successfully cleaned all targeted logs---------------------------"
        echo $finishString >> ${logPath}/logcleaning.txt
else
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        nonexecutionString="---------------${curTime} the disk usage is lower than 80%, no logs are deleted!--------------"
        echo $nonexecutionString >> ${logPath}/logcleaning.txt
fi
