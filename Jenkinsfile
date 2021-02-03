
pipeline { 
    environment {
        registry = "7akim/capstone-devops"
        registryCredential = 'dockerhub'
        dockerImage = ''
        }
         agent any
         stages {
             stage('Install dependencies') {
                steps {
                    // sh 'sudo apt-get install build-essential -y'
                    sh 'make install'
                }
             }
            stage('lint code') {
            steps {
                sh 'echo "linting started"'
                sh 'make lint'
            }
            }
            //  stage('Building image') {
            //     steps{
            //         script {
            //         dockerImage = docker.build registry + ":$BUILD_NUMBER"
            //             }
            //     }
            //  }
             stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOC_USERNAME', passwordVariable: 'DOC_PASSWORD')]) {
                sh 'docker build -t 7akim/capstone-devops .'
                }
            }
            }
            //  stage('Push Docker Image') {
            //     steps{
            //         script {
            //             docker.withRegistry( '', registryCredential ) {
            //             dockerImage.push()
            //             }  
            //         }
            //     }
            //  }
            stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOC_USERNAME', passwordVariable: 'DOC_PASSWORD')]) {
                sh '''
                    docker login -u $DOC_USERNAME -p $DOC_PASSWORD
                    docker push 7akim/capstone-devops
                    '''
                }
            }
            }         

            //  stage('Remove Unused docker image') {
            //     steps{
            //     sh "docker rmi $registry:$BUILD_NUMBER"
            //     }
            //  }
            stage('Remove Unused docker image') {
            steps {
                sh 'docker rmi $registry'
            }
            }

             stage('Deploying') {
                steps{
                    withAWS(credentials: 'aws', region: 'us-west-1') {
                        sh "eksctl create cluster --name capstone version 1.17 "
                        sh "aws eks --region us-west-1 update-kubeconfig --name capstone"
                        sh "kubectl apply -f deployment.yml"
                        sh "kubectl set image deployments/capstone-devops capstone-devops=7akim/capstone-devops:latest"
                        sh 'kubectl rollout status deployment capstone-devops'
                        sh 'kubectl get deployment capstone-devops'
                        sh 'kubectl get all'
                        sh "kubectl get pods --all-namespaces -o wide"
                    }
                }
             }
             stage("Cleaning up") {
                steps{
                    sh "docker system prune"
                }
             }
         }    
}