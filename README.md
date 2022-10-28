# airflow-k8s-operator
[Kubernetes operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) for managing airflow instances based on the [operator framework](https://operatorframework.io/) using the help-operator variant.

## Prerequisites:
- docker for mac (or minikube, kind, ect..)

- [helm](https://helm.sh/docs/intro/install/)

- postgres operator
    Airflow needs a database to run. In this example operator we use the zalando postgres-operator to provide such a database.
    ```
    git clone --depth 1 --branch v1.8.2 https://github.com/zalando/postgres-operator.git

    kubectl create namespace platform

    helm -n platform upgrade --install postgres-operator ./postgres-operator/charts/postgres-operator --set configKubernetes.enable_pod_disruption_budget=false --set image.tag=v1.8.2-26-gacb3ffd7
    ```
- nginx-ingress-controller (optional)
    To access the airflow web interface you can use the nginx ingress
    ```
    helm -n platform upgrade --install ingress-nginx ingress-nginx/ingress-nginx --set admissionWebhooks.enabled=false
    ```

## Build airflow image
We need a base image to run the airflow-instance. In order to build the image run:
```
docker build --platform linux/amd64 -t airflow-base airflow-docker
```

## Build and install the airflow-instance-operator
Build the operator image:
```
docker build -t airflow-instance-operator ./airflow-instance-operator -f ./airflow-instance-operator/build/Dockerfile
```

Deploy the operator and customresourcedefinition using helm:
```
helm upgrade -n platform --install airflow-instance-operator helm/airflow-instance-operator
```

## Install the example airflow instance
```
kubectl apply -f airflow-instance-operator/examples/example_local_airflowinstance_cr.yaml
```

Wait till the example-airflowinstance is up and running and then go to [http://localhost/airflow/default/example]

If ingress isn't working fine you can try the nodeport [http://localhost:30078/airflow/default/example]:

## Known issues
- example-airflowinstance pod is in `Init:CrashLoopBackOff` status. Solution is to wait a few restart and it should get on running state. This happens because the postgres pod is not 100% ready.