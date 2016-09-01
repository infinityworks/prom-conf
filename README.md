# Prometheus Config

## Summary

Simple container designed to populate prometheus configuration using dns autodiscovery, when deployed as part of the Prometheus catalog entry in Rancher.

## Description

This container is designed to operate as a data container, or 'sidekick' to Prometheus. It's used in the Prometheus catalog entry in Rancher to provide an auto-configuring monitoring platform.
Below, is the docker compose syntax to run this container, the expectation being this is mapped in using `volumes_from` and sidekicks.  keep in-mind this is designed around an implementation within a Rancher managed environment.

```
prom-conf:
    tty: true
    image: infinityworksltd/prom-conf:09
    volumes:
      - /etc/prom-conf/

```

## Further Info

The prom-conf container can be found on the docker hub [here](https://hub.docker.com/r/infinityworks/prom-conf/)
The catalog entry is in the community catalog, available [here](https://github.com/rancher/community-catalog)
Additional information can be found on the [guide](https://github.com/infinityworksltd/Guide_Rancher_Monitoring)

[![](https://images.microbadger.com/badges/version/infinityworks/prom-conf.svg)](http://microbadger.com/images/infinityworks/prom-conf "Get your own version badge on microbadger.com")

[![](https://images.microbadger.com/badges/image/infinityworks/prom-conf.svg)](http://microbadger.com/images/infinityworks/prom-conf "Get your own image badge on microbadger.com")
