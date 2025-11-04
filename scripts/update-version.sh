### 5. Add Version Management and Chart Validation

Create a script to help manage chart versions and validate charts:

```bash
#!/bin/bash
set -euo pipefail

# Usage: ./scripts/update-version.sh chart-name 1.2.3 [push-to-oci]

CHART=$1
VERSION=$2
PUSH_OCI=${3:-false}

if [[ ! -d "charts/${CHART}" ]]; then
    echo "Chart '${CHART}' not found"
    exit 1
fi

# Update Chart.yaml version
sed -i "s/^version:.*/version: ${VERSION}/" "charts/${CHART}/Chart.yaml"

echo "Updated ${CHART} to version ${VERSION}"
echo "Don't forget to update the changelog!"

# Validate the chart
helm lint "charts/${CHART}"
helm template "charts/${CHART}" > /dev/null
