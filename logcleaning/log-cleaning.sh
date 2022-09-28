#!/bin/bash

logPath=~/jrkeystone/logs
recyclePath=${logPath}/recyclebin

curTime=$(date '+%Y-%m-%d %H:%M:%S')
startString="--------------------$curTime daily log recycling work started!--------------------------------------------------------------------------"
echo $startString >> ${logPath}/logcleaning.txt
recycleTarget=`find ${logPath} -name "*.log*" -mtime +1`
mkdir $recyclePath
for i in $recycleTarget
do
        mv $i $recyclePath
        recycleTime=$(date '+%Y-%m-%d %H:%M:%S') 
        echo "$recycleTime log file $i has been moved to recyclebin." >> ${logPath}/logcleaning.txt
done

disk_usage=$(df -h|grep "/$"|awk '{print int($5)}')
if [ $disk_usage -gt 80 ]; then
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        removeString="--------------------$curTime the disk usage is higher than 80%, start cleaning out the recyclebin!-----------------------------------------------"
        echo $removeString >> ${logPath}/logcleaning.txt
        recyclebinSize=$(du -sm $recyclePath | awk '{print $1}')
        until [ $recyclebinSize -le 20480 ]
        do
                cleanTarget=`find $recyclePath -type f -printf '%T+ %p\n' | sort | head -n 1`
                rm -rf $cleanTarget
                removeTime=$(date '+%Y-%m-%d %H:%M:%S')
                echo "$removeTime log file $cleanTarget has been moved to recyclebin." >> ${logPath}/logcleaning.txt
        done

        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        finishString="--------------------${curTime} successfully cleaned all targeted logs!-------------------------------------------------------------------"
        echo $finishString >> ${logPath}/logcleaning.txt
else
        curTime=$(date '+%Y-%m-%d %H:%M:%S')
        nonexecutionString="--------------------${curTime} the disk usage is lower than 80%, no logs are deleted!---------------------------------------------"
        echo $nonexecutionString >> ${logPath}/logcleaning.txt
fi