#!/usr/bin/env sh

# replace default airflow image and tag
echo "setting airflow docker tag on ${AIRFLOW_DOCKER_TAG}"
sed -i 's/AIRFLOW_DOCKER_TAG/'"${AIRFLOW_DOCKER_TAG}"'/g' ${HOME}/helm-charts/airflowinstance/values.yaml
sed -i 's/AIRFLOW_DOCKER_TAG/'"${AIRFLOW_DOCKER_TAG}"'/g' ${HOME}/helm-charts/airflowinstance/templates/deployment.yaml
sed -i 's/AIRFLOW_DOCKER_TAG/'"${AIRFLOW_DOCKER_TAG}"'/g' ${HOME}/helm-charts/airflowinstance/templates/airflow-configmap.yaml
sed -i 's@AIRFLOW_DOCKER_REPOSITORY@'"${AIRFLOW_DOCKER_REPOSITORY}"'@g' ${HOME}/helm-charts/airflowinstance/values.yaml

echo "starting operator"
cd ${HOME}
/usr/local/bin/helm-operator run --watches-file=./watches.yaml
