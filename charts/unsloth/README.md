# unsloth

A Helm chart for [Unsloth Studio](https://unsloth.ai) — GPU-accelerated LLM fine-tuning and inference platform.

## Features

- Unsloth Studio UI (port 8000)
- Jupyter Lab (port 8888)
- NVIDIA GPU support via `runtimeClassName: nvidia`
- Persistent storage for workspace and HuggingFace model cache
- Configurable via ConfigMap and Secret

## Prerequisites

- Kubernetes 1.23+
- Helm 3.10+
- NVIDIA GPU node with `nvidia` RuntimeClass configured
- Storage class capable of dynamic provisioning (uses the cluster default)

## Install

```bash
helm install unsloth oci://ghcr.io/danchev/charts/unsloth
```

The default Studio image uses `latest` and is pulled whenever a pod starts.
Override `image.tag` to select a different
Studio release; `core` images do not include the Studio interface.

## Configuration

| Key | Default | Description |
|-----|---------|-------------|
| `image.repository` | `unsloth/unsloth` | Container image repository |
| `image.tag` | `""` | Image tag (defaults to chart appVersion, `latest`) |
| `image.pullPolicy` | `Always` | Image pull policy |
| `runtimeClassName` | `nvidia` | Runtime class for GPU access |
| `resources.requests.nvidia.com/gpu` | `"1"` | Number of GPUs to request |
| `persistence.work.size` | `5Gi` | Workspace volume size |
| `persistence.models.size` | `50Gi` | HuggingFace cache volume size |
| `persistence.studio.size` | `10Gi` | Unsloth Studio state and saved password volume size |
| `persistence.work.storageClass` | `""` | Uses the cluster default storage class |
| `persistence.models.storageClass` | `""` | Uses the cluster default storage class |
| `secrets.JUPYTER_PASSWORD` | `""` | Auto-generated when empty |
| `secrets.UNSLOTH_STUDIO_PASSWORD` | `""` | Auto-generated when empty |
| `services.studio.type` | `ClusterIP` | Studio service type |
| `services.jupyterlab.type` | `ClusterIP` | Jupyter Lab service type |
| `ingress.enabled` | `false` | Enable ingress for Studio |

## Accessing Unsloth

After installation, port-forward to access Studio and Jupyter Lab:

```bash
# Unsloth Studio
kubectl port-forward svc/unsloth-studio 8000:8000

# Jupyter Lab
kubectl port-forward svc/unsloth-jupyterlab 8888:8888
```

Note: First launch may take 5-10 minutes while `llama.cpp` compiles.
