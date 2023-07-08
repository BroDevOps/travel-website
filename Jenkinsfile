pipeline {
    agent any

    environment {
        SSHUSERNAME = "ubuntu"
        SCRIPTPATH = "/home/ubuntu/travel-website"
        IP = "172.31.87.102"
    }

    stages{
        stage('Build Deploy') {
            steps{
                sshagent (credentials: ['sagar_test']) {
                    sh "ssh -o StrictHostKeyChecking=no ${SSHUSERNAME}@${IP} 'cd ${SCRIPTPATH} && bash -x deploy.sh 2>&1'"
                }
            }
        }
    }
}
