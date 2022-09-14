#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        
        stage('Upload') {
            steps {
                echo 'Uploading shell script to the targeted server ... '
                sh 'pwd'
                sh 'ls -la'
                sshagent(credentials: ['logclean']) {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.62.246.235 mkdir logcleaning'
                sh 'ssh -v ubuntu@52.62.246.235'
                sh 'scp log-cleaning.shell ubuntu@52.62.246.235:/home/ubuntu'
                }
            }
        }
        
        stage('Configure') {
            steps {
                echo 'Configuring the timming service on the targeted server ...'
                sshagent(credentials: ['logclean']) {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.62.246.235 pwd'
                sh 'scp crontab ubuntu@52.62.246.235:/tmp/crontab.isn8ic'
                }
            }
        }  
    }
}