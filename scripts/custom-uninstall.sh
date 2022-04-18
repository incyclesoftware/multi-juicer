helm ls --all --short | xargs -L1 helm delete
helm ls --namespace monitoring --all --short | xargs -L1 helm delete --namespace monitoring
# helm delete multi-juicer
kubectl delete -f k8s-juice-service.yaml
kubectl delete -f k8s-monitoring-service.yaml -n monitoring