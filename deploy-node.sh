#!/bin/bash
# Deployment script for Web3 Nodes (Docker-based) [Развертывание нод]

NODE_NAME=$1
IMAGE_NAME=$2

if [ -z "$NODE_NAME" ] || [ -z "$IMAGE_NAME" ]; then
    echo "Usage: ./deploy-node.sh <node_name> <image_name>"
    exit 1
fi

echo "Deploying $NODE_NAME using image $IMAGE_NAME... [Запуск ноды...]"

# Проверка наличия Docker-сети
docker network inspect web3_network >/dev/null 2>&1 || \
    docker network create --driver bridge web3_network

# Запуск контейнера с лимитами ресурсов (важно для Dell Inspiron/Sony)
docker run -d \
    --name "$NODE_NAME" \
    --network web3_network \
    --restart unless-stopped \
    --memory="1g" \
    --cpus="0.5" \
    "$IMAGE_NAME"

echo "Node $NODE_NAME is up and running. [Нода запущена и работает.]"
