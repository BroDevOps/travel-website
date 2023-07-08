pipeline {
    agent any

    environment {
        SSHUSERNAME = "ubuntu"
        SCRIPTPATH = "/home/ubuntu/travel-website"
        IP = "100.27.24.34"
        PRIVATE_KEY = "~/Downloads/awspersonal.pem"
    }

    stages {
        stage('Build Deploy') {
            steps {
                sh "ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY} ${SSHUSERNAME}@${IP} 'cd ${SCRIPTPATH} && bash -x deploy.sh 2>&1'"
            }
        }
    }
}
