pipeline {
  environment {
    eksClusterName = 'capstone1'
    eksRegion = 'eu-central-1'
    imageVersion = 'v2'

  }

  agent any

  stages {
    stage("Cleaning up Docker Files") {
      steps{
        echo 'Cleaning up...'
        sh "docker system prune"
      }
    }


    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e ./src/templates/*.html'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'sudo docker build --tag=capstone .'
      }
    }

    stage('Push Docker Image to DockerHub') {
      steps {
        withDockerRegistry([url: "", credentialsId: "docker-hub"]) {
          echo "Pushing to DockerHub"
          sh "docker tag capstone subrockmann/udacity-capstone:$imageVersion"
          sh "docker push subrockmann/udacity-capstone:$imageVersion"
        }
      }
    }

    stage('Update kubeconfig') {
      steps {
        withAWS(credentials: 'Jenkins', region: eksRegion) {
          sh 'aws eks --region=${eksRegion} update-kubeconfig --name ${eksClusterName}'
        }
      }
    }    

    stage('Deploy cluster') {
      steps {
        withAWS(credentials: 'Jenkins', region: eksRegion) {

          sh 'kubectl apply -f ./k8/deployment.yaml'
          sh 'kubectl get nodes'
          sh 'kubectl get pod -o wide'
          sh 'kubectl get deployment'
          sh 'kubectl get service/capstone-lb'
    
        }
      }
    }  
    stage('Update image') {
      steps {
        withAWS(credentials: 'Jenkins', region: eksRegion) {
          echo 'Updating the docker image ...'
          sh "kubectl set image deployments/capstone-deployment udacity-capstone=subrockmann/udacity-capstone:$imageVersion"
          sh "kubectl get rs"
          sh 'kubectl rollout status deployments/capstone-deployment -w'
        }
      }
    } 
  }
}