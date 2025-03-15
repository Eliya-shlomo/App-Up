pipeline{

    // as deafult using my ubunto server 207.180.209.173
    agent any


    // identify env
    enviiroment {
        REGISTERY = "docker.io/eliyashlomo7"
        IMAGE_NAME = "my-nginx-site"
        TAGS = "latest"
    }

    // begging of Pipeline
    stages{

        // get to repo
        stage('Checkout') {
            steps{
                git branch: 'main', url: 'https://github.com/Eliya-Shlomo/App-Up.git'
            }
        }

        // build the docker image from the latest project version
        stage('Build docker iamge') {
            steps{
                sh ' docker build -t $REGISTERY/$IMAGE_NAME/$TAGS '
            }
        }

        // running the latest tests
        stage('Run tests') {
            steps{
                sh ' docker run --rm $REGISTERY/$IMAGE_NAME/$TAGS pytest tests/'
            }
        }

        // push image to the docker repository as last version
        stage('Push to Registry'){
            steps{
                sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                sh 'docker push $REGISTRY/$IMAGE_NAME:$TAG'
            }
        }

        // deploy service to the world
        stage('Deploy'){
            stage{
                sh 'kubectl apply -f nginx-deployment.yaml'
            }
        }

        // if failure been occurred kubectl will run the last working version
        stage('Rollback if Falling') {
            when {
                failure()
            }
            steps{
                sh 'kubectl rollout undo deployment nginx '
            }
        }
    }
}