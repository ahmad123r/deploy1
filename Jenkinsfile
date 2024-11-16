
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "suspicious-events-detector"
        DOCKER_TAG = "latest"
        REGISTRY = "ahmad201218"
        KUBECONFIG = credentials('kubeconfig-credential-id')
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build & Test') {
            steps {
                sh './mvnw clean package -DskipTests=false'
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}").push("${REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }
    post {
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
