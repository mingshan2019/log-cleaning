#!/usr/bin/env groovy

pipeline {
    agent any

    environment {
        EC2_USER    = 'ubuntu'
        IP_ADDRESS  = '13.238.204.157'  
	}
    
    stages {
        
        stage('Upload') {
            steps {
                echo 'Uploading the shell script and the conrontab configure file to the targeted folder ... '
                sshagent(credentials: ['38beab26-e12d-4f99-8a6c-a3a250f3d9f0']) {
                    sh 'scp -v -r logcleaning ${EC2_USER}@${IP_ADDRESS}:/home/${EC2_USER}'
                }
            }
        }
        
        stage('Configure') {
            steps {
                echo 'Configuring the timming service on the targeted server ...'
		        sshagent(credentials: ['38beab26-e12d-4f99-8a6c-a3a250f3d9f0']) {
                    sh 'ssh -o StrictHostKeyChecking=no ${EC2_USER}@${IP_ADDRESS} crontab ./logcleaning/crontab.config'
                }
            }
        }  
    }
}
