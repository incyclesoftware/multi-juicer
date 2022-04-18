cat ./.secrets/ghcr-pat-write | docker login ghcr.io -u mbonetti-incyclesoftware --password-stdin

docker build . -t ghcr.io/incyclesoftware/mb-juice-balancer:latest   
docker push ghcr.io/incyclesoftware/mb-juice-balancer:latest
