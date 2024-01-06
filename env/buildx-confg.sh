docker buildx create \
    --bootstrap \
    --name=kube \
    --driver=kubernetes \
    --platform=linux/amd64 \
    --node=builder-amd64 \
    --driver-opt=namespace=builders,nodeselector="kubernetes.io/arch=amd64"

docker buildx create \
    --append \
    --bootstrap \
    --name=kube \
    --driver=kubernetes \
    --platform=linux/arm64 \
    --node=builder-arm64 \
    --driver-opt=namespace=builders,nodeselector="kubernetes.io/arch=arm64"