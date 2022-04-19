cat ./.secrets/ghcr-pat-write | docker login ghcr.io -u mbonetti-incyclesoftware --password-stdin

headSha=$(git rev-parse HEAD)

docker build ../juice-balancer/ \
  -t ghcr.io/incyclesoftware/mb-juice-balancer:latest \
  -t ghcr.io/incyclesoftware/mb-juice-balancer:$headSha

docker push --all-tags ghcr.io/incyclesoftware/mb-juice-balancer
