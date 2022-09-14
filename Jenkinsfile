#!/usr/bin/env groovy

pipeline {
    agent any
    
    stages {

        stage('Cleanup docker space') {
            steps {
                echo 'Cleaning docker space ...'
                sh 'docker system prune -f'
            }
        }

        stage('Install') {
            steps {
                echo 'Installing dependencies ... '
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Installing dependencies ... '
                echo 'Noting to test at this stage ... '

            }
        }       

        stage('Build Docker Image') {
            steps {
                echo 'Building the docker image ... '
                sh 'docker build -t 258520933796.dkr.ecr.ap-southeast-1.amazonaws.com/techscrum-dev:latest .'
            }
        }

        stage('Publish to ECR') {
            steps {
                echo 'Publishing the docker image ... '
                    script {
                        docker.withRegistry("https://258520933796.dkr.ecr.ap-southeast-1.amazonaws.com", "ecr:ap-southeast-1:AWS_CREDNETIAL_ID") {
                        docker.image("258520933796.dkr.ecr.ap-southeast-1.amazonaws.com/techscrum-dev").push()
                    }
                }
            }
        }
        
        
         stage('Provision infrastructure') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
            }

            steps {
                echo 'Provision infrastructure ...'
                dir('tf-backend-techscrum') {
                    git branch: 'master', url: 'https://mingshan_bit@bitbucket.org/mingshan_bit/tf-backend-techscrum.git', credentialsId: 'bitbucketCredentials'
                    sh 'terraform init'
                    sh 'terraform apply --auto-approve'                
                }
            }
        }   
    }
}
