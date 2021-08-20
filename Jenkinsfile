#!groovy
pipeline {
    agent any


    stages {
        stage('Start') {
            steps {
                script {
                    def messageForQA = "${env.GIT_COMMITTER_NAME} started *${env.JOB_NAME} [${env.BUILD_NUMBER}]*\nApplication timeout is expected"
                    sendMessage('Gizar_chat_ID', messageForQA)
                }

            }
        }
        stage('Test') {
            steps {
                echo "Test step ...."
            }
        }

        stage('Build') {
            steps {
                echo "Build step ...."
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploy step ...."
            }
        }
    }
    post {
        success {
            script{
                def messageForQA = "*${env.JOB_NAME} [${env.BUILD_NUMBER}]* FINISHED\n\n*Status* : OK \nЧел там [последний коммит](https://github.com/nastasyafedotovna/andersen-devops-course/commit/${env.GIT_COMMIT}) успешно задеплоился\n\nCheck console output at ${env.BUILD_URL}console"
                def messageForComitter = "*${env.JOB_NAME} [${env.BUILD_NUMBER}]* FINISHED\n\n*Status* : OK \nЧел там [последний коммит](https://github.com/nastasyafedotovna/andersen-devops-course/commit/${env.GIT_COMMIT}) успешно задеплоился\n\nCheck console output at ${env.BUILD_URL}console"

                sendMessage('Gizar_chat_ID', messageForQA)
                sendMessage('Evan_chat_ID', messageForComitter)
            }
		}
            aborted {
                echo ""
	    }
            failure {
                echo ""
            }
    }
}

def sendMessage(your_chat_id, message){
    withCredentials([string(credentialsId: 'botTOKEN', variable: 'botTOKEN'), string(credentialsId: your_chat_id, variable: 'chatID')]) {
        sh  ("""
             curl -s -X POST https://api.telegram.org/bot${botTOKEN}/sendMessage -d chat_id=${chatID} -d parse_mode=markdown -d text='${message}'
        """)
    }
}