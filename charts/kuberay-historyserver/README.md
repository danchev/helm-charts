# KubeRay History Server

Deploys the upstream History Server container with S3-compatible storage. This
is a community chart; it is not an official Ray Project Helm chart.

```sh
helm repo add danchev https://danchev.github.io/helm-charts
helm install ray-historyserver danchev/kuberay-historyserver \
  --namespace ray-historyserver --create-namespace \
  --set s3.endpoint=minio.example.com:443 \
  --set s3.existingSecret=ray-history-s3-credentials
```

Create the credentials Secret in the release namespace before installation.
By default its keys are `access-key` and `secret-key`. The chart never creates
or embeds credentials. Provision the bucket and storage policy separately.

| Value | Purpose |
| --- | --- |
| `image.tag` | Upstream image version (defaults to beta `nightly`; pin for production) |
| `s3.*` | Bucket, endpoint, region, path style, Secret name and key names |
| `liveClusters.enabled` | Enable access to running Ray clusters |
| `liveClusters.useKubernetesProxy` | Route live requests through Kubernetes across namespaces |
| `cache.maxMemory` | Session cache memory ceiling |
| `serviceAccount.*`, `rbac.*` | Create or reuse the service account and cluster permissions |
| `selectorLabels` | Preserve immutable Deployment selectors during adoption |
| `resources`, `extraArgs`, `extraEnv` | Runtime settings |

Proxy mode mounts a kubeconfig referring to the pod's rotating service account
token and CA. RBAC permits listing RayClusters and, only in proxy mode, GET on
`services/proxy` across the cluster. It does not grant Secret access. Disable
`rbac.create` to supply narrower permissions yourself. Live access to Ray
clusters with authentication enabled may require additional configuration and
is not configured by this chart.

The dashboard is installed separately. Its API compatibility must be checked
against the selected History Server image. Collectors belong in the RayCluster
and RayJob pod templates; this chart does not install collectors. External buckets are provisioned separately.

## Optional Silo / MinIO Tenant subchart

Following the [Silo deployment guide](https://silo.pgsty.com/operations/deployments/k8s-deploy-minio-tenant-helm-on-kubernetes/),
this chart offers the upstream MinIO Operator **Tenant** chart 7.1.1 as the
`minioTenant` dependency. It is disabled by default. The upstream Operator
repository is archived; 7.1.1 is the guide's frozen compatibility baseline,
not a promise of continuing vendor support. Silo is a separate MinIO-compatible
server implementation. Its image is pinned and its in-place updater disabled.

Install a compatible MinIO Operator and Tenant CRDs separately before enabling
this dependency. An operator is shared cluster infrastructure and is not
installed by this chart. Enabling a tenant provisions storage in the release
namespace; it does not migrate an external bucket or its data.

```yaml
s3:
  endpoint: YOUR-TENANT-S3-ENDPOINT
  existingSecret: ray-history-s3-credentials
minioTenant:
  enabled: true
  tenant:
    name: ray-history-storage
    configSecret:
      name: ray-history-storage-config
      existingSecret: true
    pools:
      - name: pool-0
        servers: 1
        volumesPerServer: 4
        size: 10Gi
        storageClassName: YOUR-STORAGE-CLASS
```

Choose topology, storage size and TLS settings for your environment; the
example topology is for evaluation and provides no node redundancy. All
upstream tenant values are configurable under `minioTenant`. The defaults
create the `ray-historyserver` bucket during Tenant provisioning. If changing
`s3.bucket`, also update `minioTenant.tenant.buckets`. Configure the actual
Tenant endpoint and certificate trust explicitly; the chart does not guess
service URLs or disable certificate verification.

Create `ray-history-storage-config` with a `config.env` key containing the
Tenant's `MINIO_ROOT_USER` and `MINIO_ROOT_PASSWORD` exports. Separately create
a dedicated S3 principal with bucket-scoped permissions and put its credentials
in `s3.existingSecret`. Root credentials are not used by the History Server.
Configure collectors to use the same endpoint, bucket and dedicated principal.
Silo/MinIO account policy provisioning remains an administrator task.

Keep `minioTenant.enabled: false` when using an existing external S3/MinIO
installation. The dependency adds no Tenant or tenant credential Secret then.
