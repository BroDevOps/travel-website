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
        RECIPIENT_EMAIL = "sagaraulakh80@gmail.com"
    }

    stages {
        stage('Build Deploy') {
            steps {
                script {
                    // Start SSH Agent
                    sshagent (credentials: ['sagar']) {
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
            // Send email notification for both success and failure
            script {
                emailext (
                    subject: "Deployment Status for Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                    body: """<p>Deployment Status for Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                        <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>
                        <p>Result: ${currentBuild.result == 'SUCCESS' ? 'SUCCESS' : 'FAILURE'}</p>""",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                    to: RECIPIENT_EMAIL
                )
            }
        }

        failure {
            // Fail the build if the deployment script fails
            error "Deployment failed"
        }
    }
}









