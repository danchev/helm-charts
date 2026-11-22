# nvidia-gpu-exporter

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.0](https://img.shields.io/badge/AppVersion-2.0.0-informational?style=flat-square)

Prometheus exporter for NVIDIA GPUs using NVML or nvidia-smi.

**Homepage:** <https://github.com/utkuozdemir/nvidia_gpu_exporter>

## TL;DR

```console
$ helm repo add danchev https://danchev.github.io/helm-charts
$ helm install my-release danchev/nvidia-gpu-exporter
```

## Upgrading to chart 2.0.0

This release runs NVIDIA GPU Exporter 2.0.0 and explicitly defaults to the NVML
backend. Set `collectBackend: exec` to retain nvidia-smi collection. NVML exports
`nvidia_smi_nvml_return_code` instead of `nvidia_smi_command_exit_code`;
shared GPU metrics retain their names and labels.

The default node selector requires `nvidia.com/gpu.present: "true"`. Ensure GPU
nodes carry this label; override `nodeSelector` if your cluster uses another
label. NVML exits at startup if the driver library is unavailable.

Default host library paths assume Debian/Ubuntu x86_64 GPU nodes. For SUSE/RHEL,
set the `volumes` host paths to `/usr/lib64/libnvidia-ml.so` and
`/usr/lib64/libnvidia-ml.so.1`, while retaining the container `volumeMounts` paths
under `/usr/lib/x86_64-linux-gnu/`. Host paths and container paths need not match.
Override the complete lists when changing `volumes` or `volumeMounts`.

The chart retains its existing privileged UID 0 security context for host-device
access. The exporter image is shell-less. Custom nvidia-smi commands and fields
outside the NVML catalog require `collectBackend: exec`.

Use `extraArgs` for additional exporter flags and `extraEnv` for container
variables, for example:

```yaml
collectBackend: nvml
extraArgs:
  - --collect.pcie-throughput
extraEnv:
  - name: LD_LIBRARY_PATH
    value: /usr/lib/x86_64-linux-gnu
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for the pod assignment |
| collectBackend | string | `"nvml"` | Collection backend: nvml (direct driver access) or exec (nvidia-smi). |
| extraArgs | list | `[]` | Additional exporter command-line arguments. |
| extraEnv | list | `[]` | Additional container environment variables, including valueFrom references. |
| fullnameOverride | string | `""` | String to fully override fullname template with a string |
| hostNetwork | bool | `false` |  |
| hostPort.enabled | bool | `false` | Enable hostPort |
| hostPort.port | int | `9835` | The hostPort to listen to |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/utkuozdemir/nvidia_gpu_exporter"` | Image repository |
| image.tag | string | `""` | Image tag (if not specified, defaults to the chart's appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.annotations | object | `{}` | Annotations for the Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | exposing the metrics of the GPU on the node it is on |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | Ingress hosts configuration |
| ingress.tls | list | `[]` | The TLS configuration for the Ingress |
| log.format | string | `"logfmt"` | Log format to be used by the exporter |
| log.level | string | `"info"` | Log level to be used by the exporter |
| nameOverride | string | `""` | String to partially override fullname template with a string (will prepend the release name) |
| nodeSelector | object | `{"nvidia.com/gpu.present":"true"}` | The node selector for the deployment |
| nvidiaSmiCommand | string | `"nvidia-smi"` | The command to run to get `nvidia-smi` compatible output. Can be custom path and/or args. |
| podAnnotations | object | `{}` | Annotations for the pods |
| podSecurityContext | object | `{}` | Security context for the pods |
| port | int | `9835` | Port for the exporter to listen to |
| queryFieldNames | list | `["AUTO"]` | Query fields to be collected by the exporter |
| resources | object | `{}` | The resource requests and limits of the container |
| securityContext | object | `{"privileged":true,"runAsUser":0}` | Security context for the container. Privileged is required for the collector to work properly. |
| service.enabled | bool | `true` | Enables the Service |
| service.nodePort | string | `nil` | The node port to use if service type is NodePort or LoadBalancer. |
| service.port | int | `9835` | Port for the service to use |
| service.type | string | `"ClusterIP"` | Type of the service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | see [values.yaml](values.yaml) | Prometheus PodMonitor configuration |
| telemetryPath | string | `"/metrics"` | The path to expose the metrics from |
| tolerations | list | `[]` | Tolerations for the pod assignment |
| volumeMounts | list | see [values.yaml](values.yaml) | The container mount configurations for the volumes |
| volumes | list | see [values.yaml](values.yaml) | The volumes to mount from the host |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Dobri Danchev | <12420863+danchev@users.noreply.github.com> | <https://danchev.github.io/helm-charts/> |

## Source Code

* <https://github.com/danchev/helm-charts/tree/master/charts/nvidia-gpu-exporter>
* <https://github.com/utkuozdemir/nvidia_gpu_exporter>
* <https://github.com/utkuozdemir/helm-charts>

## Attribution

This chart is derived from [Utku Özdemir's Helm charts](https://github.com/utkuozdemir/helm-charts).
The [NVIDIA GPU Exporter](https://github.com/utkuozdemir/nvidia_gpu_exporter) is an upstream project by Utku Özdemir.
