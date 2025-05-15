# Helm Charts Repository

This repository contains Helm charts for deploying various applications on Kubernetes.

## Available Charts

- [chart-vllm](charts/chart-vllm) - A Helm chart for deploying vLLM, a high-throughput and memory-efficient inference engine for LLMs.

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
