#!/bin/bash
set -euo pipefail

# Usage: ./scripts/oci-push.sh chart-name registry-url [version]

CHART=$1
REGISTRY=$2
VERSION=$3

if [[ ! -d "charts/${CHART}" ]]; then
    echo "Chart '${CHART}' not found"
    exit 1
fi

# If version is specified, update the chart version first
if [[ -n "${VERSION:-}" ]]; then
    sed -i "s/^version:.*/version: ${VERSION}/" "charts/${CHART}/Chart.yaml"
    echo "Updated ${CHART} to version ${VERSION}"
fi

# Package and push to OCI registry
echo "Packaging chart..."
helm package "charts/${CHART}" --destination .deploy

# Push to OCI registry
echo "Pushing to OCI registry ${REGISTRY}..."
helm push .deploy/${CHART}-*.tgz oci://${REGISTRY}/charts

echo "Chart ${CHART} successfully pushed to OCI registry"
