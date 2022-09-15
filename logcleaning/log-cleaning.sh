#!/bin/bash

logPath=/var/log

target_logs=`find ${logpath} -name "*.log" -mtime +7`
disk_usage=$(df -h|grep "/$"|awk '{print int($5)}')
if [ $disk_usage -gt 80 ]; then
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        startString="--------------------${curTime} daily log cleaning work started!------------------------------"
        sudo echo $startString >> ${logPath}/shell.txt
        for i in $target_logs
                do
                rm -rf ${logPath}/$i
                deleteTime=$(date '+%Y-%m-%d %H:%M:%S')

                sudo echo "$deleteTime log file $i was deleted." >> ${logPath}/shell.txt
                done;
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        finishString="---------------------${curTime} successfully cleaned all targeted logs---------------------------"
        sudo echo $finishString >> ${logPath}/shell.txt
else
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        nonexecutionString="---------------${curTime} the disk usage is lower than 80%, no logs are deleted!--------------"
        sudo echo $nonexecutionString >> ${logPath}/shell.txt
fi