# Helm Charts Repository

This repository contains Helm charts for deploying various applications on Kubernetes.

## Available Charts

- [chart-vllm](charts/chart-vllm) - A Helm chart for deploying vLLM, a high-throughput and memory-efficient inference engine for LLMs.
- [nvidia-gpu-exporter](charts/nvidia-gpu-exporter) - A Helm chart for deploying the NVIDIA GPU Exporter, which exposes GPU metrics to Prometheus.

## Getting Started

### Adding the Helm Repository

```bash
helm repo add vllm https://danchev.github.io/helm-charts
helm repo update
```

### Installing the Chart

```bash
helm install vllm vllm/chart-vllm
```
