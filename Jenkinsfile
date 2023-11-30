pipeline {
    agent any

    environment {
        SSHUSERNAME = "ubuntu"
        SCRIPTPATH = "/home/ubuntu/travel-website"
        IP = "3.7.253.159"
    }

    stages {
        stage('Build Deploy') {
            steps {
                echo "Deploying to ${IP}..."
                sshagent(credentials: ['ubuntu']) {
                    sh "echo 'Running on ${IP} as ${SSHUSERNAME}'"
                    sh "ssh -o StrictHostKeyChecking=no ${SSHUSERNAME}@${IP} 'cd ${SCRIPTPATH} && bash -x deploy.sh 2>&1'"
                }
            }
        }
    }
}
