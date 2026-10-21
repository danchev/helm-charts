[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/danchev)](https://artifacthub.io/packages/search?repo=danchev)

# Helm Charts Repository

This repository contains Helm charts for deploying various applications on Kubernetes.

## Available Charts

- [aibrix](charts/aibrix) - A Helm chart for deploying AIBrix, cloud-native LLM inference infrastructure.
- [nvidia-gpu-exporter](charts/nvidia-gpu-exporter) - A Helm chart for deploying the NVIDIA GPU Exporter, which exposes GPU metrics to Prometheus.
- [kuberay-historyserver](charts/kuberay-historyserver) - A Helm chart for deploying the KubeRay History Server, with S3 storage and an optional live cluster proxy.
- [kuberay-dashboard](charts/kuberay-dashboard) - A Helm chart for deploying the KubeRay Dashboard, a web UI for managing Ray clusters.
- [vllm](charts/vllm) - A Helm chart for deploying vLLM, a high-throughput and memory-efficient inference engine for LLMs.
- [unsloth](charts/unsloth) - A Helm chart for deploying Unsloth Studio and Jupyter Lab for GPU-accelerated LLM fine-tuning and inference.

## Getting Started

### Adding the Helm Repository

```bash
helm repo add danchev https://danchev.github.io/helm-charts
helm repo update danchev
```

### Installing a Chart

For AIBrix, first install the [matching external dependencies](charts/aibrix/README.md#dependencies), then install the chart:

```bash
helm install aibrix danchev/aibrix --version 0.8.0 -n aibrix-system --create-namespace
```

To install the NVIDIA GPU Exporter chart:

```bash
helm install nvidia-gpu-exporter danchev/nvidia-gpu-exporter
```

To install the KubeRay Dashboard chart:

```bash
helm install kuberay-dashboard danchev/kuberay-dashboard
```

Published chart archives are also available through OCI at
`oci://ghcr.io/danchev/charts/<chart-name>`.

For more details, see the README in each chart directory.
