
pipeline { 
    environment {
        registry = "7akim/capstone-devops"
        registryCredential = 'dockerhub'
        dockerImage = ''
        }
         agent any
         stages {
             stage('Lint HTML') {
                steps {
                    sh 'tidy -q -e *.html'
                    sh 'hadolint Dockerfile'
                }
             }
             stage('Building image') {
                steps{
                    script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                        }
                }
             }
             stage('Push Docker Image') {
                steps{
                    script {
                        docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                        }  
                    }
                }
             }

             stage('Remove Unused docker image') {
                steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
                }
             }
             stage('Deploying') {
                steps{
                    withAWS(credentials: 'aws', region: 'us-west-1') {
                        sh "aws eks --region us-west-1 update-kubeconfig --name capstone"
                        sh "kubectl apply -f deployment.yml"
                        sh "kubectl set image deployments/capstone-devops capstone-devops=7akim/capstone-devops:latest"
                        sh 'kubectl rollout status deployment capstone-devops'
                        sh 'kubectl get deployment capstone-devops'
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