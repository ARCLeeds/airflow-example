#!/bin/bash

# first time environment setup for docker-compose requires some setup

mkdir -p ./dags ./logs ./plugins

echo -e "AIRFLOW_UID=$(id -u)" > .env