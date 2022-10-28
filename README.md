# airflow-k8s-operator
Kubernetes operator for managing airflow instances

## Build airflow image
```
docker build --platform linux/amd64 -t airflow-base airflow-docker
```

## Build airflow-instance-operator image
```
docker build -t airflow-instance-operator ./airflow-instance-operator -f ./airflow-instance-operator/build/Dockerfile
```

## Deploy psql operator
```
git clone --depth 1 --branch v1.8.2 https://github.com/zalando/postgres-operator.git

kubectl create namespace platform

helm -n platform upgrade --install postgres-operator ./postgres-operator/charts/postgres-operator --set configKubernetes.enable_pod_disruption_budget=false --set image.tag=v1.8.2-26-gacb3ffd7
```

## Install the airflow-instance-operator
```
helm upgrade -n platform --install airflow-instance-operator helm/airflow-instance-operator
```

## Install nginx
```
helm -n platform upgrade --install ingress-nginx ingress-nginx/ingress-nginx --set admissionWebhooks.enabled=false
```

## Install example airflow instance
```
kaf airflow-instance-operator/examples/example_local_airflowinstance_cr.yaml
```

Wait till the example-airflowinstance is up and running and then go to [http://localhost/airflow/default/example]

If ingress isn't working fine you can try the nodeport [http://localhost:30078/airflow/default/example]:
