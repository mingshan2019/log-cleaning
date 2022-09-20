#!/usr/bin/env groovy

pipeline {
    agent any
    
    environment {
		CI = 'true'
		JR_ENVIRONMENT = 'PROD'
		EC2_USER = 'ubuntu'
		IP_ADDRESS_BLUE = '52.62.246.235'
		IP_ADDRESS_GREEN = '54.206.20.223'
		BITBUCKET_REPO = 'git@bitbucket.org:jiang_ren/jrkeystone.git'
		WORKSPACE_PATH = '/var/jenkins_home/workspace/JRKeystone-prod'
		DISTRIBUTION_ID = 'EMMSHZ9OV1DYK' 
		PATHS_TO_INVALIDATE = '/*'
		REGION = 'ap-southeast-2'
	}
    
    stages {
        
        stage('Upload') {
            steps {
                echo 'Uploading the shell script and the conrontab configure file to the targeted folder ... '
                sshagent(credentials: ['logclean']) {
                sh 'ssh -v ${EC2_USER}@${IP_ADDRESS_BLUE}'
                sh 'scp -v -r logcleaning ${EC2_USER}@${IP_ADDRESS_BLUE}:/home/ubuntu'
                }
            }
        }
        
        stage('Configure') {
            steps {
                echo 'Configuring the timming service on the targeted server ...'
                sshagent(credentials: ['logclean']) {
                sh 'ssh -o StrictHostKeyChecking=no ${EC2_USER}@${IP_ADDRESS_BLUE} crontab ./logcleaning/crontab.config'
                }
            }
        }  
    }
}
