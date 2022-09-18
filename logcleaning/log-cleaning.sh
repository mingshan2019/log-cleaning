#!/bin/bash

logPath=~/jrkeystone/logs/
recyclePath=${logPath}recyclebin
echo $recyclePath >> ${logPath}logcleaning.txt

target_logs=`find ${logPath} -name "*.log.*" -mtime +6`
echo $target_logs >> ${logPath}logcleaning.txt

disk_usage=$(df -h|grep "/$"|awk '{print int($5)}')
if [ $disk_usage -gt 20 ]; then
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        startString="--------------------${curTime} daily log cleaning work started!------------------------------"
        echo $startString >> ${logPath}/logcleaning.txt
        mkdir $recyclePath
        find ${logpath} -name "*.log.*" -mtime +7 | xargs -i mv {} $recyclePath
        deleteTime=$(date '+%Y-%m-%d %H:%M:%S') 
        for i in $target_logs
                do
                echo "$deleteTime log file $i has been moved to recyclebin." >> ${logPath}/logcleaning.txt
                done;
        #find /tmp/RecycleBin/ -name "*.log.*" -exec rm -rf {} \
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        finishString="---------------------${curTime} successfully cleaned all targeted logs---------------------------"
        echo $finishString >> ${logPath}/logcleaning.txt
else
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        nonexecutionString="---------------${curTime} the disk usage is lower than 80%, no logs are deleted!--------------"
        echo $nonexecutionString >> ${logPath}/logcleaning.txt
fi
