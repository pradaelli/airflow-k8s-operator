#!/usr/bin/env bash

source /tmp/common.sh

case "${AIRFLOW_ROLE}" in
  webserver)
    blue 'Starting Airflow webserver'
    exec airflow "${AIRFLOW_ROLE}"
    ;;
  scheduler)
    blue 'Starting Airflow scheduler'
    exec airflow "${AIRFLOW_ROLE}"
    ;;
  *)
    abort "Unsupported role ${AIRFLOW_ROLE}"
    ;;
esac
