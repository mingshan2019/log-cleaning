#!/bin/bash

logPath=~/jrkeystone/logs
recyclePath=${logPath}/recyclebin

target_logs=`find ${logPath} -name "*.log*" -mtime +5`

disk_usage=$(df -h|grep "/$"|awk '{print int($5)}')
if [ $disk_usage -gt 20 ]; then
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        startString="--------------------${curTime} daily log cleaning work started!--------------------------------------------------------------------------"
        echo $startString >> ${logPath}/logcleaning.txt
        mkdir $recyclePath
        for i in $target_logs
                do
                mv $i $recyclePath
                deleteTime=$(date '+%Y-%m-%d %H:%M:%S') 
                echo "$deleteTime log file $i has been moved to recyclebin." >> ${logPath}/logcleaning.txt
                done;
        #rm -rf $recyclePath
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        finishString="--------------------${curTime} successfully cleaned all targeted logs-------------------------------------------------------------------"
        echo $finishString >> ${logPath}/logcleaning.txt
else
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        nonexecutionString="--------------------${curTime} the disk usage is lower than 80%, no logs are deleted!---------------------------------------------"
        echo $nonexecutionString >> ${logPath}/logcleaning.txt
fi
