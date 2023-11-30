// pipeline {
//     agent any

//     environment {
//         SSHUSERNAME = "ubuntu"
//         SCRIPTPATH = "/home/ubuntu/travel-website"
//         BASTION_IP = "3.7.253.159"
//         PRIVATE_IP = "10.0.131.51"
//     }

//     stages {
//         stage('Build Deploy') {
//             steps {
//                 echo "Deploying to ${PRIVATE_IP} via bastion at ${BASTION_IP}..."
//                 sshagent(credentials: ['ubuntu']) {
//                     sh "echo 'Running on ${PRIVATE_IP} as ${SSHUSERNAME}'"
//                     sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ubuntu@${PRIVATE_IP} 'cd ${SCRIPTPATH} && pwd && ls && bash -x deploy.sh 2>&1'"
//                 }
//             }
//         }
//     }
// }
pipeline {
    agent any

    environment {
        SSHUSERNAME = "ubuntu"
        SCRIPTPATH = "/home/ubuntu/travel-website"
        BASTION_IP = "3.7.253.159"
        PRIVATE_IP = "10.0.131.51"
    }

    stages {
        stage('Build Deploy') {
            steps {
                script {
                    // Print debugging information
                    echo "Running on ${PRIVATE_IP} as ${SSHUSERNAME}"

                    // Verify SSH connectivity
                    sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ubuntu@${PRIVATE_IP} 'echo SSH Successful'"

                    // Verify Docker is running on the remote server
                    sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ubuntu@${PRIVATE_IP} 'docker ps'"

                    // Add Jenkins user to the docker group
                    sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ubuntu@${PRIVATE_IP} 'sudo usermod -aG docker jenkins'"

                    // Retry the Docker command
                    retry(3) {
                        sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ubuntu@${PRIVATE_IP} 'cd ${SCRIPTPATH} && docker-compose up -d --build'"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Additional steps or cleanup, if needed
                echo "Adding Jenkins user to the docker group..."
                sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ubuntu@${PRIVATE_IP} 'sudo usermod -aG docker jenkins'"
            }
        }
    }
}
