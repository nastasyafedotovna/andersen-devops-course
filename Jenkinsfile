#!groovy
pipeline {
    agent any
    environment{
      BUILD_TRIGGER_BY = "${currentBuild.getBuildCauses()[0].shortDescription} / ${currentBuild.getBuildCauses()[0].userId}"

    }

    stages {
        stage('Start') {
            steps {
         withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${BUILD_TRIGGER_BY}\nJob: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n'
        """)
        }
            }
        }
        stage('Test') {
            steps {
         withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Test stage*:OK'
        """)
        }
            }
        }
        stage('Build') {
            steps {
         withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build stage*:OK'
        """)
        }
            }
        }
        stage('Deploy') {
            steps {
         withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'Evan_chatID', variable: 'Evan_chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='ЗАЛУПА ТЫ АПХПАХПАХХПАХПАХПА' """
        }
            }
        }
    }
    post {
            success {            
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build* : OK \n*Published* = YES \n\nCheck console output at "${env.BUILD_URL}"'
        """)
        }
			}
            aborted {             
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${BUILD_TRIGGER_BY}\nJob: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build* : Aborted \n*Published* = NO \n\nCheck console output at "${env.BUILD_URL}"'
        """)
			}
	    }
            failure {
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${BUILD_TRIGGER_BY}\nJob: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build* : Failed \n*Published* = NO \n\nCheck console output at "${env.BUILD_URL}"'
        """)
            }
       }
}
}
