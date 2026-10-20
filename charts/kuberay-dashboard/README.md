# kuberay-dashboard

![Version: 0.0.6](https://img.shields.io/badge/Version-0.0.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.7.1](https://img.shields.io/badge/AppVersion-v1.7.1-informational?style=flat-square)

A Helm chart for KubeRay Dashboard

**Homepage:** <https://github.com/ray-project/kuberay/tree/master/dashboard>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Dobri Danchev |  | <https://danchev.github.io/helm-charts/> |

## Source Code

* <https://github.com/danchev/helm-charts/tree/master/charts/kuberay-dashboard>

## Installation

Provide a reachable KubeRay API server through `apiServer.url`; this chart deploys
the dashboard, not the API server.

```bash
helm repo add danchev https://danchev.github.io/helm-charts
helm repo update danchev
helm install kuberay-dashboard danchev/kuberay-dashboard --version 0.0.6 -f my-values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| apiServer.url | string | `"http://kuberay-apiserver-service.default.svc.cluster.local:8888/apis/ray.io/v1"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| httpRoute | object | `{"annotations":{},"enabled":false,"hostnames":["ray-dashboard.local"],"parentRefs":[{"name":"gateway","sectionName":"http"}],"rules":[{"matches":[{"path":{"type":"PathPrefix","value":"/headers"}}]}]}` | Expose the service via gateway-api HTTPRoute Requires Gateway API resources and suitable controller installed within the cluster (see: https://gateway-api.sigs.k8s.io/guides/) |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/kuberay/dashboard"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"ray-dashboard.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |


## History Server and deployment extensions

Set `historyServer.url` to enable the dashboard's History Server integration.
The History Server and collector sidecars are installed separately.
`containerPort` defaults to 3000 independently of `service.port`.

Use `command`, `args`, `extraEnv`, `extraContainers`, `extraObjects`, `volumes`
and `volumeMounts` for optional runtime extensions. `extraObjects` accepts
literal Kubernetes objects, not Helm template strings. Values do not contain
any compatibility patches by default: supply version-specific workarounds in
your deployment values. Customization of compiled assets requires reviewing
those workarounds when the image changes.

When migrating an existing Deployment, set `selectorLabels` to its exact
immutable selector and `fullnameOverride` to its current name. Preserve the
existing service name and port to avoid breaking routes.
