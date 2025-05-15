[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/danchev)](https://artifacthub.io/packages/search?repo=danchev)

# Helm Charts Repository

This repository contains Helm charts for deploying various applications on Kubernetes.

## Available Charts

- [aibrix](charts/aibrix) - A Helm chart for deploying AIBrix, a high-performance AI inference engine.
- [nvidia-gpu-exporter](charts/nvidia-gpu-exporter) - A Helm chart for deploying the NVIDIA GPU Exporter, which exposes GPU metrics to Prometheus.
- [kuberay-dashboard](charts/kuberay-dashboard) - A Helm chart for deploying the Ray Dashboard, a web UI for monitoring and managing Ray clusters.
- [vllm](charts/vllm) - A Helm chart for deploying vLLM, a high-throughput and memory-efficient inference engine for LLMs.

## Getting Started

### Adding the Helm Repository

```bash
helm repo add danchev https://danchev.github.io/helm-charts
helm repo update
```

### Installing a Chart

To install the AIBrix chart:

```bash
helm install aibrix danchev/aibrix -n aibrix-system --create-namespace
```

To install the NVIDIA GPU Exporter chart:

```bash
helm install nvidia-gpu-exporter danchev/nvidia-gpu-exporter
```

To install the Ray Dashboard chart:

```bash
helm install kuberay-dashboard danchev/kuberay-dashboard
```

Replace `vllm`, `nvidia-gpu-exporter`, `kuberay-dashboard` with your desired release names.

For more details, see the README in each chart directory.
