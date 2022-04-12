helm ls --all --short | xargs -L1 helm delete
helm ls --namespace monitoring --all --short | xargs -L1 helm delete --namespace monitoring

kubectl delete --file k8s-juice-service.yaml
# kubectl delete --namespace monitoring --file k8s-monitoring-service.yaml