FROM quay.io/operator-framework/helm-operator:v0.19.0

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
USER root
RUN chown -R ${USER_UID} ${HOME}/helm-charts/

COPY build/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
USER ${USER_UID}

ENTRYPOINT ["/docker-entrypoint.sh"]
