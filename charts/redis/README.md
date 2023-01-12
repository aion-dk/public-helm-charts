# Redis

redis explain

## Prerequisites

- Kubernetes 1.22+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
## First install the repo
helm repo add aion https://aion-dk.github.io/public-helm-charts/
helm repo update


## Install the redis helm chart
$ helm install --name my-release aion/redis
```

> **Tip**: List all releases using `helm list`

## Upgrading the Chart

```console
## Update the repos first
helm repo update

## Upgrade the chart
helm upgrade my-release
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the cert-manager chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `image.repository` | Image repository | `redis` |
| `image.tag` | Image tag | `7-alpine` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `service.name` | Service name, Will be set to full name, if unset. (Default) | `` |
| `service.port` | Service Port | `6379` |
| `service.type` | Service type | `ClusterIP` |
| `service.headless` | Should the service run headless | true |
| `resources` | Service | `{limits: {cpu: 100m, memory: 200Mi}, requests: {cpu: 50m, memory: 100Mi}}` |




Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml .
```
> **Tip**: You can use the default [values.yaml](values.yaml)

## Contributing

This chart is maintained at [https://github.com/aion-dk/public-helm-charts](https://github.com/aion-dk/public-helm-charts).