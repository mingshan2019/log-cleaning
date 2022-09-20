#!/usr/bin/env groovy

pipeline {
    agent any
    
    environment {
		EC2_USER = 'ubuntu'
		IP_ADDRESS = '52.62.246.235'
	    	SSH_AGENT_CREDENTIALS = 'logclean'
	}
    
    stages {
        
        stage('Upload') {
            steps {
                echo 'Uploading the shell script and the conrontab configure file to the targeted folder ... '
		    sshagent(credentials: [${SSH_AGENT_CREDENTIALS}]) {
                sh 'scp -v -r logcleaning ${EC2_USER}@${IP_ADDRESS}:/home/ubuntu'
                }
            }
        }
        
        stage('Configure') {
            steps {
                echo 'Configuring the timming service on the targeted server ...'
                sshagent(credentials: ['logclean']) {
                sh 'ssh -o StrictHostKeyChecking=no ${EC2_USER}@${IP_ADDRESS} crontab ./logcleaning/crontab.config'
                }
            }
        }  
    }
}
