// pipeline {
//     agent any

//     environment {
//         SSHUSERNAME = "ubuntu"
//         SCRIPTPATH = "/home/ubuntu/travel-website"
//         BASTION_IP = "65.2.84.242"
//         PRIVATE_IP = "10.10.10.151"
//     }

//     stages {
//         stage('Build Deploy') {
//             steps {
//                 script {
//                     // Start SSH Agent
//                     sshagent (credentials: ['sagar']) {
//                         // Forward SSH Agent to Bastion
//                         sh "ssh -A -o StrictHostKeyChecking=yes ${SSHUSERNAME}@${BASTION_IP} 'ssh-add -L'"

//                         // Connect to Private Server via Bastion
//                         sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ${SSHUSERNAME}@${PRIVATE_IP} 'cd ${SCRIPTPATH} && bash -x deploy.sh 2>&1'"
//                     }
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
        BASTION_IP = "65.2.84.242"
        PRIVATE_IP = "10.10.10.151"
    }

    stages {
        stage('Build Deploy') {
            steps {
                script {
                    // Start SSH Agent
                    sshagent(credentials: ['sagar']) {
                        // Forward SSH Agent to Bastion
                        sh "ssh -A -o StrictHostKeyChecking=yes ${SSHUSERNAME}@${BASTION_IP} 'ssh-add -L'"

                        // Connect to Private Server via Bastion
                        sh "ssh -o StrictHostKeyChecking=no -J ${SSHUSERNAME}@${BASTION_IP} ${SSHUSERNAME}@${PRIVATE_IP} 'cd ${SCRIPTPATH} && bash -x deploy.sh 2>&1'"
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up steps if needed
        }

        success {
            emailext subject: "Success - Deployment Status for Job '${env.JOB_NAME}'",
                      body: """<p>Deployment was successful. Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME}</a></p>""",
                      to: 'sagaraulakh80@gmail.com'
        }

        failure {
            emailext subject: "Failure - Deployment Status for Job '${env.JOB_NAME}'",
                      body: """<p>Deployment failed. Check console output at <a href='${env.BUILD_URL}'>${env.JOB_NAME}</a></p>""",
                      to: 'sagaraulakh80@gmail.com'
        }
    }
}








