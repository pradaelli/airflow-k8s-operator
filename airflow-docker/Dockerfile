# VERSION 1.10.10
# DESCRIPTION: Basic Airflow container
# BUILD: docker build --rm --platform linux/amd64 -t airflow-base airflow-docker

FROM python:3.7-slim
LABEL maintainer="pradaelli"

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Airflow
ARG airflow_version=1.10.10
ENV AIRFLOW_VERSION ${airflow_version}
ENV AIRFLOW_HOME /opt/airflow
ENV AIRFLOW_GPL_UNIDECODE yes
ENV PYTHONPATH ${AIRFLOW_HOME}

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

RUN apt-get update \
    && apt-get install -yqq --no-install-recommends \
        build-essential \
        apt-utils \
        locales \
        curl \
        jq \
        net-tools \
        netcat \
        procps \
    && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow \
    && chown -R airflow: ${AIRFLOW_HOME} \
    && pip install \
        --no-cache-dir \
        kubernetes==11.0.0 \
        Werkzeug==0.16.1 \
        jinja2==2.10.1 \
        marshmallow==2.18.0 \
        Flask==1.1.1 \
        SQLAlchemy==1.3.15 \
        boto3 \
        virtualenv \
        boxsdk[jwt]==1.5.5 \
        cerberus-python-client==2.3.* \
        MarkupSafe==2.0.1 \
        itsdangerous==2.0.1 \
        apache-airflow[crypto,postgres,jdbc,kubernetes,slack]==$AIRFLOW_VERSION \
        adal \
        xlrd \
        xhtml2pdf \
        marshmallow-sqlalchemy==0.18.0 \
        ldap3==2.6.1 \
        flask-cors \
        coverage>=5.3 \
        freezegun==1.1.0 \
        wtforms==2.3.3 \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

COPY airflow_base/scripts/common.sh /tmp/

COPY airflow_base/scripts/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY airflow_base/plugins ${AIRFLOW_HOME}/plugins/

COPY airflow_base/scripts/init-airflow.sh ${AIRFLOW_HOME}/
RUN chmod +x ${AIRFLOW_HOME}/init-airflow.sh

WORKDIR ${AIRFLOW_HOME}

ENTRYPOINT ["/docker-entrypoint.sh"]
