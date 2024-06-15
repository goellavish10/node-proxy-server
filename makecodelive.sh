DOCKER_IMAGE_NAME="proxyapp"
DOCKER_CONTAINER_NAME="proxyapp_container"
PORT=9000

echo "Fetching latest changes..."
git pull origin main

echo "Building Docker image..."
sudo docker build --build-arg PORT=$PORT -t $DOCKER_IMAGE_NAME .

echo "Stopping and removing existing Docker container..."
sudo docker stop $DOCKER_CONTAINER_NAME
sudo docker rm $DOCKER_CONTAINER_NAME

echo "Running new Docker container..."
sudo docker run -d -p $PORT:$PORT --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE_NAME

echo "Application updated and running successfully!"