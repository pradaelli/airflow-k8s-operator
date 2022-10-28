#!/usr/bin/env bash

source /tmp/common.sh

blue 'Initializing airflow database'
wait_for "${DB_HOST}" "${DB_PORT}"
airflow initdb

if [ -f "${AIRFLOW_HOME}/variables.json" ]; then
  blue 'Importing configuration variables'
  airflow variables --import "${AIRFLOW_HOME}/variables.json"
fi

# set airflow_db connection correctly
airflow connections -d --conn_id airflow_db
airflow connections -a \
  --conn_id airflow_db \
  --conn_type postgres \
  --conn_host "${DB_HOST}" \
  --conn_port "${DB_PORT}" \
  --conn_login airflow \
  --conn_password airflow
