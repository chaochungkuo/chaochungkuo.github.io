---
title: Configuring Prometheus and Grafana for Ubuntu Servers
date: 2024-04-23
categories: [IT, monitoring]
tags: [docker, prometheus, grafana, ubuntu]  # TAG names should always be lowercase
published: true
---

In our institute, we have a few Ubuntu servers that we want to monitor. In order to monitor these servers, we will use Prometheus and Grafana. Here are the steps to install and configure Prometheus and Grafana on Ubuntu servers.

## Key Concepts

- Monitoring server: Prometheus, Grafana, Node_exporter, and cadvisor.
- Other computational servers: Prometheus, Node_exporter, and cadvisor without Grafana.

## Installation with docker-compose

First, create the directories for Prometheus and Grafana data and configuration files.

```bash
sudo mkdir /data/monitoring/
sudo chown -R mount:genomics /data/monitoring/
sudo chmod -R 775 /data/monitoring/
```

And then enter the directory and create two files:

- docker-compose.yml
- prometheus.yml

```bash
cd /data/monitoring/
touch docker-compose.yml prometheus.yml
```

### docker-compose.yml

This file contains the configuration for Docker containers.

```yaml
version: '3.8'
networks:
  monitoring:
    driver: bridge
volumes:
  grafana-data:
    driver: local
services:
  prometheus:
    image: prom/prometheus:v2.37.9
    container_name: prometheus
    ports:
      - 9090:9090
    command:
      - '--config.file=/etc/prometheus/prometheus.yaml'
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yaml
      - ./data:/prometheus
    restart: unless-stopped
  
  node_exporter:
    image: quay.io/prometheus/node-exporter:v1.5.0
    container_name: node_exporter
    command: '--path.rootfs=/host'
    pid: host
    restart: unless-stopped
    volumes:
      - /:/host:ro

  cadvisor:
    image: gcr.io/cadvisor/cadvisor:v0.47.0
    container_name: cadvisor
    command:
      - '-port=8098'
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /dev/disk/:/dev/disk:ro
    devices:
      - /dev/kmsg
    privileged: true
    restart: unless-stopped
```

If you want to monitor other computational servers with Grafana, you can add the Grafana service in the docker-compose.yml file.

```yaml
grafana:
    image: grafana/grafana-oss:latest
    container_name: grafana
    ports:
      - '3000:3000'
    volumes:
      - grafana-data:/var/lib/grafana
    restart: unless-stopped
```

### prometheus.yml

This file contains the configuration for Prometheus.

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['myapi:6003']
    metrics_path: '/tam-metrics'

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node_exporter:9100']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8098']
```

## Start the containers

After creating the docker-compose.yml and prometheus.yml files, you can start the containers with the following command:

```bash
docker-compose up -d
```

This command will start all the containers in the background. You can check the status of the containers with the following command:

```bash
docker-compose ps
```

## Access the Grafana Dashboard

Open your web browser and go to http://your-server-ip:3000. The default username and password are both `admin`. Please change the password as soon as possible.

## Configure Prometheus to Scrape the Servers
