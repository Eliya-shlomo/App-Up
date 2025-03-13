pipeline{
    agent any

    enviiroment {
        REGISTERY = "docker.io/eliyashlomo7"
        IMAGE_NAME = "my-nginx-site"
        TAGS = "latest"
    }



    stages{

        stage('Checkout') {
            steps{
                git branch: 'main', url: 'https://github.com/Eliya-Shlomo/App-Up.git'
            }
        }

        stage('Build docker iamge') {
            steps{
                sh ' docker build -t $REGISTERY/$IMAGE_NAME/$TAGS '
            }
        }

        stage('Run tests') {
            steps{
                sh ' docker run --rm $REGISTERY/$IMAGE_NAME/$TAGS pytest tests/'
            }
        }

        stage('Push to Registry'){
            steps{
                sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                sh 'docker push $REGISTRY/$IMAGE_NAME:$TAG'
            }
        }

        stage('Deploy'){
            stage{
                sh 'kubectl apply -f nginx-deployment.yaml'
            }
        }

        stage('Rollback if Falling') {
            when {
                faliure()
            }
            steps{
                sh 'kubectl rollout undo deployment nginx '
            }
        }
    }
}