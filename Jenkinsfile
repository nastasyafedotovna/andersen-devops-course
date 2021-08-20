#!groovy
pipeline {
    agent any
    environment{
      BUILD_TRIGGER_BY = "${currentBuild.getBuildCauses()[0].shortDescription} / ${currentBuild.getBuildCauses()[0].userId}"

    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    post {
            success {            
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${BUILD_TRIGGER_BY}\n*${env.JOB_NAME}* : POC \n*Branch*: ${env.GIT_BRANCH} \n*Build* : OK \n*Published* = YES'
        """)
        }
			}
            aborted {             
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC *Branch*: ${env.GIT_BRANCH} *Build* : Aborted *Published* = NO'
        """)
			}
	    }
            failure {
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${BUILD_TRIGGER_BY}\n*${env.JOB_NAME}* : POC *Branch*: ${env.GIT_BRANCH} *Build* : Failed *Published* = YES'
        """)
            }
       }
}
}
