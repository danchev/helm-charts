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
- Storage class capable of dynamic provisioning (default: `longhorn`)

## Install

```bash
helm install unsloth oci://ghcr.io/danchev/helm-charts/unsloth
```

## Configuration

| Key | Default | Description |
|-----|---------|-------------|
| `image.repository` | `unsloth/unsloth` | Container image repository |
| `image.tag` | `""` | Image tag (defaults to chart appVersion) |
| `runtimeClassName` | `nvidia` | Runtime class for GPU access |
| `resources.requests.nvidia.com/gpu` | `"1"` | Number of GPUs to request |
| `persistence.work.size` | `5Gi` | Workspace volume size |
| `persistence.models.size` | `50Gi` | HuggingFace cache volume size |
| `persistence.work.storageClass` | `longhorn` | Storage class for workspace |
| `persistence.models.storageClass` | `longhorn` | Storage class for model cache |
| `secrets.JUPYTER_PASSWORD` | `unsloth` | Jupyter Lab password |
| `secrets.USER_PASSWORD` | `unsloth` | User password |
| `services.studio.type` | `ClusterIP` | Studio service type |
| `services.lab.type` | `ClusterIP` | Jupyter Lab service type |
| `ingress.enabled` | `false` | Enable ingress for Studio |

## Accessing Unsloth

After installation, port-forward to access Studio and Jupyter Lab:

```bash
# Unsloth Studio
kubectl port-forward svc/unsloth-studio 8000:8000

# Jupyter Lab
kubectl port-forward svc/unsloth-lab 8888:8888
```

Note: First launch may take 5-10 minutes while `llama.cpp` compiles.
