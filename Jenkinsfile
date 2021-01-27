pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
                sh 'tidy -q -e *.html'
                sh 'hadolint Dockerfile'
            }
        }
        stage('Build Docker Image') {
            steps {
                  sh 'docker build -t 7akim/capstone-devops .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'docker push 7akim/capstone-devops'
                }  
            }
        }
        stage('Deploying') {
            steps{
                withAWS(credentials: 'aws', region: 'us-west-1') {
                    sh "aws eks --region us-west-1 update-kubeconfig --name capstone"
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl set image deployments/capstone-cloud-devops capstone-cloud-devops=7akim/capstone-devops:latest"
                    sh 'kubectl rollout status deployment capstone-cloud-devops'
                    sh 'kubectl get deployment capstone-cloud-devops'
                    sh 'kubectl get all'
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