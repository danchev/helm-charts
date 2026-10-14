#!/bin/bash
set -euo pipefail

# Run from the repository root.
# Usage: ./scripts/oci-push.sh chart-name registry/owner [version]
# Example registry namespace: ghcr.io/danchev

if (( $# < 2 || $# > 3 )); then
    echo "Usage: $0 chart-name registry/owner [version]" >&2
    exit 1
fi

CHART=$1
REGISTRY=${2#oci://}
REGISTRY=${REGISTRY%/}
VERSION=${3:-}

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
chart_metadata=$(helm show chart "charts/${CHART}")
chart_name=$(awk '/^name:/ {print $2}' <<< "$chart_metadata")
chart_version=$(awk '/^version:/ {print $2}' <<< "$chart_metadata")
mkdir -p .deploy
helm package "charts/${CHART}" --destination .deploy

# Push to OCI registry
echo "Pushing to OCI registry ${REGISTRY}..."
helm push ".deploy/${chart_name}-${chart_version}.tgz" "oci://${REGISTRY}/charts"

echo "Chart ${CHART} successfully pushed to OCI registry"
