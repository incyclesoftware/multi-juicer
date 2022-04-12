# ########################################################
# # Install nginx
# ########################################################

# echo "Installing nginx..."
# helm repo add nginx-stable https://helm.nginx.com/stable
# helm install nginx nginx-stable/nginx-ingress

########################################################
# Install Prometheus, Grafana & Grafana Loki
########################################################

echo "Installing monitoring..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

kubectl create namespace monitoring

echo "Installing prometheus-operator..."
wget -N https://raw.githubusercontent.com/iteratec/multi-juicer/master/guides/monitoring-setup/prometheus-operator-config.yaml

echo "Installing Prometheus Operator & Grafana..."
helm --namespace monitoring upgrade --install monitoring prometheus-community/kube-prometheus-stack --version 13.3.0 --values prometheus-operator-config.yaml

echo "Installing loki..."
helm --namespace monitoring upgrade --install loki grafana/loki --version 2.3.0 --set="serviceMonitor.enabled=true"

echo "Installing loki/promtail..."
helm --namespace monitoring upgrade --install promtail grafana/promtail --version 3.0.4 --set "config.lokiAddress=http://loki:3100/loki/api/v1/push" --set="serviceMonitor.enabled=true"

########################################################
# Install MultiJuicer
########################################################

echo "Installing MultiJuicer..."
helm repo add multi-juicer https://iteratec.github.io/multi-juicer/
helm install multi-juicer multi-juicer/multi-juicer \
  --set balancer.metrics.enabled=true \
  --set balancer.metrics.dashboards.enabled=true \
  --set balancer.metrics.serviceMonitor.enabled=true \
  --set balancer.metrics.basicAuth.password="GNVUfA2WyhAVGDXZbjCU" \
  --set grafana.adminPassword="N!K&brr&i4dsn*v8*Jn" \
  --set juiceShop.maxInstances=20 \
  # --set juiceShop.config= \
  # --set ingress.enabled=true \
  # --set ingress.annotations."kubernetes\.io/ingress\.class"=nginx \
  # --set ingress.hosts[0].host="cybersecurity.tsa-challange.org" \
  # --set ingress.hosts[0].paths[0]="/"
  

# We got a example loadbalancer yaml for this example in the repository
wget -N https://raw.githubusercontent.com/iteratec/multi-juicer/master/guides/k8s/k8s-juice-service.yaml

# Create the loadbalancers

kubectl apply --file k8s-juice-service.yaml
# # kubectl apply --namespace monitoring --file k8s-monitoring-service.yaml

