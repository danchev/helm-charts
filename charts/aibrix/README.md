# aibrix

![Version: 0.7.0](https://img.shields.io/badge/Version-0.7.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.7.0](https://img.shields.io/badge/AppVersion-0.7.0-informational?style=flat-square)

Cloud-native LLM inference infrastructure with distributed inference, KV caching, intelligent routing, and autoscaling capabilities

**Homepage:** <https://github.com/vllm-project/aibrix>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| AIBrix Team |  | <https://github.com/vllm-project/aibrix> |

## Source Code

* <https://github.com/vllm-project/aibrix>

## Installation

### Dependencies
Apply required dependencies:
```
kubectl apply --server-side -k https://github.com/vllm-project/aibrix/config/dependency
```

### Helm Install

Install AIBrix with the default values:
```
helm repo add aibrix https://danchev.github.io/helm-charts
helm install aibrix aibrix/aibrix -n aibrix-system --create-namespace
```

Or use a custom values file:

```
helm install aibrix aibrix/aibrix -f my-values.yaml -n aibrix-system --create-namespace
```


### Verification

```
helm list -A
kubectl get all -n aibrix-system
```


### Helm upgrade

Upgrade to the latest chart version:
```
helm upgrade aibrix aibrix/aibrix -n aibrix-system
```


### Helm Uninstall

Remove the release:
```
helm uninstall aibrix -n aibrix-system
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certmanager.enable | bool | `false` |  |
| controllerManager.affinity | object | `{}` |  |
| controllerManager.container.envs | object | `{}` |  |
| controllerManager.container.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| controllerManager.container.image.repository | string | `"aibrix/controller-manager"` |  |
| controllerManager.container.image.tag | string | `"v0.7.0"` |  |
| controllerManager.container.probes.liveness.httpGet.path | string | `"/healthz"` |  |
| controllerManager.container.probes.liveness.httpGet.port | int | `8081` |  |
| controllerManager.container.probes.liveness.initialDelaySeconds | int | `15` |  |
| controllerManager.container.probes.liveness.periodSeconds | int | `20` |  |
| controllerManager.container.probes.readiness.httpGet.path | string | `"/readyz"` |  |
| controllerManager.container.probes.readiness.httpGet.port | int | `8081` |  |
| controllerManager.container.probes.readiness.initialDelaySeconds | int | `5` |  |
| controllerManager.container.probes.readiness.periodSeconds | int | `10` |  |
| controllerManager.container.resources.limits.cpu | string | `"500m"` |  |
| controllerManager.container.resources.limits.memory | string | `"128Mi"` |  |
| controllerManager.container.resources.requests.cpu | string | `"10m"` |  |
| controllerManager.container.resources.requests.memory | string | `"64Mi"` |  |
| controllerManager.gatewayTimeoutSeconds | int | `120` |  |
| controllerManager.imagePullSecrets | list | `[]` |  |
| controllerManager.replicas | int | `1` |  |
| controllerManager.serviceAccount.annotations | object | `{}` |  |
| controllerManager.serviceAccount.create | bool | `true` |  |
| controllerManager.serviceAccount.name | string | `""` |  |
| controllerManager.tolerations | list | `[]` |  |
| crd.enable | bool | `true` |  |
| crd.keep | bool | `true` |  |
| fullnameOverride | string | `""` |  |
| gateway.backendTrafficPolicy.circuitBreaker.maxConnections | int | `1024` |  |
| gateway.backendTrafficPolicy.circuitBreaker.maxParallelRequests | int | `1024` |  |
| gateway.backendTrafficPolicy.circuitBreaker.maxParallelRetries | int | `1024` |  |
| gateway.backendTrafficPolicy.circuitBreaker.maxPendingRequests | int | `1024` |  |
| gateway.backendTrafficPolicy.circuitBreaker.maxRequestsPerConnection | int | `1024` |  |
| gateway.backendTrafficPolicy.http2.maxConcurrentStreams | int | `1024` |  |
| gateway.clientTrafficPolicy.connection.bufferLimit | int | `4194304` |  |
| gateway.clientTrafficPolicy.connection.connectionLimit.value | int | `1024` |  |
| gateway.clientTrafficPolicy.http2.maxConcurrentStreams | int | `1024` |  |
| gateway.enable | bool | `true` |  |
| gateway.envoyAsSideCar | bool | `false` |  |
| gateway.envoyPatchPolicy.circuitBreakers.maxConnections | int | `1024` |  |
| gateway.envoyPatchPolicy.circuitBreakers.maxPendingRequests | int | `1024` |  |
| gateway.envoyPatchPolicy.circuitBreakers.maxRequests | int | `1024` |  |
| gateway.envoyPatchPolicy.preserveExternalRequestID | bool | `false` |  |
| gateway.envoyPatchPolicy.route.connectTimeout | string | `"6s"` |  |
| gateway.envoyPatchPolicy.route.idleTimeout | string | `"300s"` |  |
| gateway.envoyPatchPolicy.route.timeout | string | `"120s"` |  |
| gateway.envoyProxy.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].preference.matchExpressions[0].key | string | `"nvidia.com/gpu.present"` |  |
| gateway.envoyProxy.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].preference.matchExpressions[0].operator | string | `"NotIn"` |  |
| gateway.envoyProxy.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].preference.matchExpressions[0].values[0] | string | `"true"` |  |
| gateway.envoyProxy.affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| gateway.envoyProxy.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].key | string | `"app.kubernetes.io/name"` |  |
| gateway.envoyProxy.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].operator | string | `"In"` |  |
| gateway.envoyProxy.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].values[0] | string | `"envoy"` |  |
| gateway.envoyProxy.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"kubernetes.io/hostname"` |  |
| gateway.envoyProxy.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| gateway.envoyProxy.container.envoy.image | string | `"envoyproxy/envoy:v1.33.2"` |  |
| gateway.envoyProxy.container.envoy.resources.limits.cpu | string | `"1"` |  |
| gateway.envoyProxy.container.envoy.resources.limits.memory | string | `"1Gi"` |  |
| gateway.envoyProxy.container.envoy.resources.requests.cpu | string | `"1"` |  |
| gateway.envoyProxy.container.envoy.resources.requests.memory | string | `"1Gi"` |  |
| gateway.envoyProxy.container.shutdownManager.image | string | `"envoyproxy/gateway:v1.2.8"` |  |
| gateway.envoyProxy.container.shutdownManager.resources.requests.cpu | string | `"10m"` |  |
| gateway.envoyProxy.container.shutdownManager.resources.requests.memory | string | `"32Mi"` |  |
| gateway.envoyProxy.imagePullSecrets | list | `[]` |  |
| gateway.envoyProxy.replicas | int | `1` |  |
| gateway.envoyProxy.tolerations | list | `[]` |  |
| gateway.envoySideCar.ports.http | int | `10080` |  |
| gatewayPlugin.container.envs.AIBRIX_GRPC_MAX_MESSAGE_SIZE_BYTES | string | `"4194304"` |  |
| gatewayPlugin.container.envs.AIBRIX_POD_METRIC_REFRESH_INTERVAL_MS | string | `"50"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFILL_REQUEST_TIMEOUT | string | `"60"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_BLOCK_SIZE | string | `"128"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_POD_RUNNING_REQUEST_IMBALANCE_ABS_COUNT | string | `"16"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_STANDARD_DEVIATION_FACTOR | string | `"2"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_TOKENIZER_TYPE | string | `"character"` |  |
| gatewayPlugin.container.envs.AIBRIX_STATESYNC_ENABLED | string | `"false"` |  |
| gatewayPlugin.container.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| gatewayPlugin.container.image.repository | string | `"aibrix/gateway-plugins"` |  |
| gatewayPlugin.container.image.tag | string | `"v0.7.0"` |  |
| gatewayPlugin.container.probes.liveness.failureThreshold | int | `3` |  |
| gatewayPlugin.container.probes.liveness.grpc.port | int | `50052` |  |
| gatewayPlugin.container.probes.liveness.initialDelaySeconds | int | `5` |  |
| gatewayPlugin.container.probes.liveness.periodSeconds | int | `10` |  |
| gatewayPlugin.container.probes.liveness.timeoutSeconds | int | `3` |  |
| gatewayPlugin.container.probes.readiness.failureThreshold | int | `3` |  |
| gatewayPlugin.container.probes.readiness.grpc.port | int | `50052` |  |
| gatewayPlugin.container.probes.readiness.initialDelaySeconds | int | `5` |  |
| gatewayPlugin.container.probes.readiness.periodSeconds | int | `10` |  |
| gatewayPlugin.container.probes.readiness.timeoutSeconds | int | `3` |  |
| gatewayPlugin.container.resources.limits.cpu | string | `"1"` |  |
| gatewayPlugin.container.resources.limits.memory | string | `"1Gi"` |  |
| gatewayPlugin.container.resources.requests.cpu | string | `"1"` |  |
| gatewayPlugin.container.resources.requests.memory | string | `"1Gi"` |  |
| gatewayPlugin.dependencies.redis.host | string | `""` |  |
| gatewayPlugin.dependencies.redis.password | string | `""` |  |
| gatewayPlugin.dependencies.redis.port | int | `6379` |  |
| gatewayPlugin.extProc.backendSettings.circuitBreaker.maxConnections | int | `1024` |  |
| gatewayPlugin.extProc.backendSettings.circuitBreaker.maxParallelRequests | int | `1024` |  |
| gatewayPlugin.extProc.backendSettings.circuitBreaker.maxParallelRetries | int | `1024` |  |
| gatewayPlugin.extProc.backendSettings.circuitBreaker.maxPendingRequests | int | `1024` |  |
| gatewayPlugin.extProc.backendSettings.circuitBreaker.maxRequestsPerConnection | int | `1024` |  |
| gatewayPlugin.failOpen | bool | `false` |  |
| gatewayPlugin.imagePullSecrets | list | `[]` |  |
| gatewayPlugin.initContainer.image.repository | string | `"busybox"` |  |
| gatewayPlugin.initContainer.image.tag | string | `"stable"` |  |
| gatewayPlugin.messageTimeout | string | `"60s"` |  |
| gatewayPlugin.replicaCount | int | `1` |  |
| gatewayPlugin.service.type | string | `"ClusterIP"` |  |
| gatewayPlugin.serviceAccount.annotations | object | `{}` |  |
| gatewayPlugin.serviceAccount.create | bool | `true` |  |
| gatewayPlugin.serviceAccount.name | string | `""` |  |
| gatewayPlugin.tolerations | list | `[]` |  |
| global.imagePullSecrets | list | `[]` |  |
| gpuOptimizer.affinity | object | `{}` |  |
| gpuOptimizer.container.image.repository | string | `"aibrix/metadata-service"` |  |
| gpuOptimizer.container.image.tag | string | `"v0.7.0"` |  |
| gpuOptimizer.container.resources.limits.cpu | string | `"500m"` |  |
| gpuOptimizer.container.resources.limits.memory | string | `"256Mi"` |  |
| gpuOptimizer.container.resources.requests.cpu | string | `"10m"` |  |
| gpuOptimizer.container.resources.requests.memory | string | `"64Mi"` |  |
| gpuOptimizer.dependencies.redis.host | string | `""` |  |
| gpuOptimizer.dependencies.redis.password | string | `""` |  |
| gpuOptimizer.dependencies.redis.port | int | `6379` |  |
| gpuOptimizer.imagePullSecrets | list | `[]` |  |
| gpuOptimizer.replicaCount | int | `1` |  |
| gpuOptimizer.serviceAccount.annotations | object | `{}` |  |
| gpuOptimizer.serviceAccount.create | bool | `true` |  |
| gpuOptimizer.serviceAccount.name | string | `""` |  |
| gpuOptimizer.tolerations | list | `[]` |  |
| metadata.redis.container.image.repository | string | `"redis"` |  |
| metadata.redis.container.image.tag | string | `"7.4"` |  |
| metadata.redis.container.resources.requests.cpu | string | `"100m"` |  |
| metadata.redis.container.resources.requests.memory | string | `"100Mi"` |  |
| metadata.redis.enablePassword | bool | `false` |  |
| metadata.redis.enabled | bool | `true` |  |
| metadata.redis.imagePullSecrets | list | `[]` |  |
| metadata.redis.password | string | `""` |  |
| metadata.redis.replicas | int | `1` |  |
| metadata.service.affinity | object | `{}` |  |
| metadata.service.container.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| metadata.service.container.image.repository | string | `"aibrix/metadata-service"` |  |
| metadata.service.container.image.tag | string | `"v0.7.0"` |  |
| metadata.service.container.resources.limits.cpu | string | `"500m"` |  |
| metadata.service.container.resources.limits.memory | string | `"512Mi"` |  |
| metadata.service.container.resources.requests.cpu | string | `"50m"` |  |
| metadata.service.container.resources.requests.memory | string | `"128Mi"` |  |
| metadata.service.imagePullSecrets | list | `[]` |  |
| metadata.service.initContainer.image.repository | string | `"busybox"` |  |
| metadata.service.initContainer.image.tag | string | `"stable"` |  |
| metadata.service.redis.host | string | `""` |  |
| metadata.service.redis.password | string | `""` |  |
| metadata.service.redis.port | int | `6379` |  |
| metadata.service.replicas | int | `1` |  |
| metadata.service.tolerations | list | `[]` |  |
| metadata.serviceAccount.annotations | object | `{}` |  |
| metadata.serviceAccount.create | bool | `true` |  |
| metadata.serviceAccount.name | string | `""` |  |
| nameOverride | string | `""` |  |
| openTelemetry.enable | bool | `false` |  |
| openTelemetry.host | string | `""` |  |
| openTelemetry.namespace | string | `""` |  |
| openTelemetry.port | int | `4317` |  |
| openTelemetry.samplingRate | Envoy-side only | `100` | The sampling rate for distributed tracing. Note: This configuration currently only applies to Envoy's internal tracing. The external authorization/processing plugin (Go service) currently uses a default always-on sampler (100%). If you set this to a low value (e.g., 10), be aware that the Go plugin will still export spans for all requests it processes. |
| openTelemetry.serviceName | string | `""` |  |
| prometheus.enable | bool | `false` |  |
| webhook.enable | bool | `true` |  |

