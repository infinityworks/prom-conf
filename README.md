# Prometheus Config

Simple container designed to populate prometheus configuration using confd, when deployed as part of the Prometheus catalog entry in Rancher.

## Auto-reload

This container can auto-reload Prometheus when the config updates. To do this, you need to volume mount the Docker socket to `/var/run/docker.sock`. By default it will look for a container running the "prom/prometheus" image, but this can be overriden with an environment variable `PROMETHEUS_IMAGE_NAME`.
