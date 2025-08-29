[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/danchev)](https://artifacthub.io/packages/search?repo=danchev)

# Helm Charts Repository

This repository contains Helm charts for deploying various applications on Kubernetes.

## Available Charts

- [chart-vllm](charts/chart-vllm) - A Helm chart for deploying vLLM, a high-throughput and memory-efficient inference engine for LLMs.
- [nvidia-gpu-exporter](charts/nvidia-gpu-exporter) - A Helm chart for deploying the NVIDIA GPU Exporter, which exposes GPU metrics to Prometheus.

## Getting Started

### Adding the Helm Repository

```bash
helm repo add danchev https://danchev.github.io/helm-charts
helm repo update
```

### Installing a Chart

To install the vLLM chart:

```bash
helm install vllm danchev/chart-vllm
```

To install the NVIDIA GPU Exporter chart:

```bash
helm install nvidia-gpu-exporter danchev/nvidia-gpu-exporter
```

Replace `vllm` and `nvidia-gpu-exporter` with your desired release names.

For more details, see the README in each chart directory.
