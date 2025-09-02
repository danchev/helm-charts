# aibrix

![Version: 0.4.1](https://img.shields.io/badge/Version-0.4.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.4.1](https://img.shields.io/badge/AppVersion-0.4.1-informational?style=flat-square)

Cloud-native LLM inference infrastructure with distributed inference, KV caching, intelligent routing, and autoscaling capabilities

**Homepage:** <https://github.com/vllm-project/aibrix>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| AIBrix Team |  | <https://github.com/vllm-project/aibrix> |

## Source Code

* <https://github.com/vllm-project/aibrix>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certmanager.enable | bool | `false` |  |
| controllerManager.container.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| controllerManager.container.image.repository | string | `"aibrix/controller-manager"` |  |
| controllerManager.container.image.tag | string | `"nightly"` |  |
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
| crd.enable | bool | `true` |  |
| crd.keep | bool | `true` |  |
| gateway.clientTrafficPolicy.connection.bufferLimit | int | `4194304` |  |
| gateway.envoyPatchPolicy.route.connectTimeout | string | `"6s"` |  |
| gateway.envoyPatchPolicy.route.timeout | string | `"120s"` |  |
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
| gatewayPlugin.container.envs.AIBRIX_POD_METRIC_REFRESH_INTERVAL_MS | string | `"50"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFILL_REQUEST_TIMEOUT | string | `"60"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_BLOCK_SIZE | string | `"128"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_POD_RUNNING_REQUEST_IMBALANCE_ABS_COUNT | string | `"16"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_STANDARD_DEVIATION_FACTOR | string | `"2"` |  |
| gatewayPlugin.container.envs.AIBRIX_PREFIX_CACHE_TOKENIZER_TYPE | string | `"character"` |  |
| gatewayPlugin.container.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| gatewayPlugin.container.image.repository | string | `"aibrix/gateway-plugins"` |  |
| gatewayPlugin.container.image.tag | string | `"nightly"` |  |
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
| gatewayPlugin.dependencies.redis.host | string | `"aibrix-redis-master"` |  |
| gatewayPlugin.dependencies.redis.port | int | `6379` |  |
| gatewayPlugin.imagePullSecrets | list | `[]` |  |
| gatewayPlugin.initContainer.image.repository | string | `"busybox"` |  |
| gatewayPlugin.initContainer.image.tag | string | `"stable"` |  |
| gatewayPlugin.messageTimeout | string | `"60s"` |  |
| gatewayPlugin.replicaCount | int | `1` |  |
| global.imagePullSecrets | list | `[]` |  |
| gpuOptimizer.container.image.repository | string | `"aibrix/runtime"` |  |
| gpuOptimizer.container.image.tag | string | `"nightly"` |  |
| gpuOptimizer.container.resources.limits.cpu | string | `"500m"` |  |
| gpuOptimizer.container.resources.limits.memory | string | `"256Mi"` |  |
| gpuOptimizer.container.resources.requests.cpu | string | `"10m"` |  |
| gpuOptimizer.container.resources.requests.memory | string | `"64Mi"` |  |
| gpuOptimizer.dependencies.redis.host | string | `"aibrix-redis-master"` |  |
| gpuOptimizer.dependencies.redis.port | int | `6379` |  |
| gpuOptimizer.imagePullSecrets | list | `[]` |  |
| gpuOptimizer.replicaCount | int | `1` |  |
| metadata.redis.container.image.repository | string | `"redis"` |  |
| metadata.redis.container.image.tag | string | `"7.4"` |  |
| metadata.redis.container.resources.requests.cpu | string | `"100m"` |  |
| metadata.redis.container.resources.requests.memory | string | `"100Mi"` |  |
| metadata.redis.imagePullSecrets | list | `[]` |  |
| metadata.redis.replicas | int | `1` |  |
| metadata.service.container.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| metadata.service.container.image.repository | string | `"aibrix/metadata-service"` |  |
| metadata.service.container.image.tag | string | `"nightly"` |  |
| metadata.service.container.resources.limits.cpu | string | `"500m"` |  |
| metadata.service.container.resources.limits.memory | string | `"256Mi"` |  |
| metadata.service.container.resources.requests.cpu | string | `"10m"` |  |
| metadata.service.container.resources.requests.memory | string | `"64Mi"` |  |
| metadata.service.imagePullSecrets | list | `[]` |  |
| metadata.service.initContainer.image.repository | string | `"busybox"` |  |
| metadata.service.initContainer.image.tag | string | `"stable"` |  |
| metadata.service.metricRefreshIntervalMs | string | `"3600000"` |  |
| metadata.service.redis.host | string | `"aibrix-redis-master"` |  |
| metadata.service.redis.port | int | `6379` |  |
| metadata.service.replicas | int | `1` |  |
| prometheus.enable | bool | `false` |  |
| webhook.enable | bool | `true` |  |

