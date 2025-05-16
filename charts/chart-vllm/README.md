# chart-vllm

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart vllm

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Autoscaling configuration |
| autoscaling.enabled | bool | `false` | Enable autoscaling |
| autoscaling.maxReplicas | int | `100` | Maximum replicas |
| autoscaling.minReplicas | int | `1` | Minimum replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization for autoscaling |
| configs | object | `{}` | Configmap |
| containerPort | int | `8000` | Container port |
| customObjects | list | `[]` | Custom Objects configuration |
| deploymentStrategy | object | `{}` | Deployment strategy configuration |
| externalConfigs | list | `[]` | External configuration |
| extraContainers | list | `[]` | Additional containers configuration |
| extraInit | object | `{"awsEc2MetadataDisabled":true,"pvcStorage":"1Gi","s3modelpath":"relative_s3_model_path/opt-125m"}` | Additional configuration for the init container |
| extraInit.pvcStorage | string | `"1Gi"` | Storage size of the s3 |
| extraInit.s3modelpath | string | `"relative_s3_model_path/opt-125m"` | Path of the model on the s3 which hosts model weights and config files |
| extraPorts | list | `[]` | Additional ports configuration |
| gpuModels | list | `["TYPE_GPU_USED"]` | Type of gpu used |
| image | object | `{"command":["vllm","serve","/data/","--served-model-name","opt-125m","--dtype","float32","--block-size","16","--host","0.0.0.0","--port","8000"],"repository":"vllm/vllm-openai","tag":"latest"}` | Image configuration |
| image.command | list | `["vllm","serve","/data/","--served-model-name","opt-125m","--dtype","float32","--block-size","16","--host","0.0.0.0","--port","8000"]` | Container launch command |
| image.repository | string | `"vllm/vllm-openai"` | Image repository |
| image.tag | string | `"latest"` | Image tag |
| labels.environment | string | `"test"` |  |
| labels.release | string | `"test"` |  |
| livenessProbe | object | `{"failureThreshold":5,"httpGet":{"path":"/health","port":8000},"initialDelaySeconds":15,"periodSeconds":10}` | Liveness probe configuration |
| livenessProbe.failureThreshold | int | `5` | Number of times after which if a probe fails in a row, Kubernetes considers that the overall check has failed: the container is not alive |
| livenessProbe.httpGet | object | `{"path":"/health","port":8000}` | Configuration of the Kubelet http request on the server |
| livenessProbe.httpGet.path | string | `"/health"` | Path to access on the HTTP server |
| livenessProbe.httpGet.port | int | `8000` | Name or number of the port to access on the container, on which the server is listening |
| livenessProbe.initialDelaySeconds | int | `15` | Number of seconds after the container has started before liveness probe is initiated |
| livenessProbe.periodSeconds | int | `10` | How often (in seconds) to perform the liveness probe |
| maxUnavailablePodDisruptionBudget | string | `""` | Disruption Budget Configuration |
| readinessProbe | object | `{"failureThreshold":5,"httpGet":{"path":"/health","port":8000},"initialDelaySeconds":5,"periodSeconds":5}` | Readiness probe configuration |
| readinessProbe.failureThreshold | int | `5` | Number of times after which if a probe fails in a row, Kubernetes considers that the overall check has failed: the container is not ready |
| readinessProbe.httpGet | object | `{"path":"/health","port":8000}` | Configuration of the Kubelet http request on the server |
| readinessProbe.httpGet.path | string | `"/health"` | Path to access on the HTTP server |
| readinessProbe.httpGet.port | int | `8000` | Name or number of the port to access on the container, on which the server is listening |
| readinessProbe.initialDelaySeconds | int | `5` | Number of seconds after the container has started before readiness probe is initiated |
| readinessProbe.periodSeconds | int | `5` | How often (in seconds) to perform the readiness probe |
| replicaCount | int | `1` | Number of replicas |
| resources | object | `{"limits":{"cpu":4,"memory":"16Gi","nvidia.com/gpu":1},"requests":{"cpu":4,"memory":"16Gi","nvidia.com/gpu":1}}` | Resource configuration |
| resources.limits."nvidia.com/gpu" | int | `1` | Number of gpus used |
| resources.limits.cpu | int | `4` | Number of CPUs |
| resources.limits.memory | string | `"16Gi"` | CPU memory configuration |
| resources.requests."nvidia.com/gpu" | int | `1` | Number of gpus used |
| resources.requests.cpu | int | `4` | Number of CPUs |
| resources.requests.memory | string | `"16Gi"` | CPU memory configuration |
| secrets | object | `{}` | Secrets configuration |
| serviceName | string | `nil` | Service name |
| servicePort | int | `80` | Service port |

## Files

- Chart.yaml: Defines the chart metadata including name, version, and maintainers.
- ct.yaml: Configuration for chart testing.
- lintconf.yaml: Linting rules for YAML files.
- values.schema.json: JSON schema for validating values.yaml.
- values.yaml: Default values for the Helm chart.
- templates/_helpers.tpl: Helper templates for defining common configurations.
- templates/configmap.yaml: Template for creating ConfigMaps.
- templates/custom-objects.yaml: Template for custom Kubernetes objects.
- templates/deployment.yaml: Template for creating Deployments.
- templates/hpa.yaml: Template for Horizontal Pod Autoscaler.
- templates/job.yaml: Template for Kubernetes Jobs.
- templates/poddisruptionbudget.yaml: Template for Pod Disruption Budget.
- templates/pvc.yaml: Template for Persistent Volume Claims.
- templates/secrets.yaml: Template for Kubernetes Secrets.
- templates/service.yaml: Template for creating Services.
