#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {
        
        stage('Upload') {
            steps {
                echo 'Uploading the shell script and the conrontab configure file to the targeted folder ... '
                sshagent(credentials: ['logclean']) {
                sh 'ssh -v ubuntu@52.62.246.235'
                sh 'scp -v -r logcleaning ubuntu@52.62.246.235:/home/ubuntu'
                }
            }
        }
        
        stage('Configure') {
            steps {
                echo 'Configuring the timming service on the targeted server ...'
                sshagent(credentials: ['logclean']) {
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@52.62.246.235 crontab ./logcleaning/crontab.config'
                }
            }
        }  
    }
}