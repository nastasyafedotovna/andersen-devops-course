#!groovy
pipeline {
    agent any

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
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n*Branch*: ${env.GIT_BRANCH} \n*Test stage*:OK'
        """)
        }
            }
        }
        stage('Build') {
            steps {
         withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n*Branch*: ${env.GIT_BRANCH} \n*Build stage*:OK'
        """)
        }
            }
        }
        stage('Deploy') {
            steps {
         withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Deploy stage*:OK'
        """)
        }
            }
        }
    }
    post {
            success {            
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build* : OK \n*Published* = YES \n\nCheck console output at ${env.BUILD_URL}console'
        """)
        }
			}
            aborted {
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'chatID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${BUILD_TRIGGER_BY}\nJob: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build* : Aborted \n*Published* = NO \n\nCheck console output at ${env.BUILD_URL}console'
        """)
			}
	    }
            failure {
        withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: 'Gizar_chat_ID', variable: 'chatID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='Job: *${env.JOB_NAME} [${env.BUILD_NUMBER}]* \n\n*Branch*: ${env.GIT_BRANCH} \n*Build* : Failed \n*Published* = NO \n\nЧел там [последний коммит](https://github.com/nastasyafedotovna/andersen-devops-course/commit/${env.GIT_COMMIT}) паламалася\n\nCheck console output at ${env.BUILD_URL}console'
        """)
            }
       }
}
}
