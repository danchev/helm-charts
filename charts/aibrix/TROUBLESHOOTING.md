# AIBrix troubleshooting

Applies to AIBrix 0.8.0 with Envoy Gateway v1.2.8.

## Routing

- Automatic routing expects `aibrix-eg` in `aibrix-system`. Model labels belong on
  both Deployment metadata and pod templates; create a backing Service.
- Check HTTPRoute `Accepted`/`ResolvedRefs`, ready model pods, and routing strategy.
  Direct port-forward success does not prove gateway routing works.
- Cross-namespace Service backends require a ReferenceGrant in the backend
  namespace. The model router creates grants for discovered workloads.
- Configure managed gateway exposure through `gateway.envoyProxy.service.type`;
  do not edit the generated Service. Its inherited default is LoadBalancer.
- Sidecar mode also uses LoadBalancer; Helm `--wait` needs an allocated address.
  Managed-gateway TLS and telemetry settings do not configure the sidecar.

## Authentication and storage

Bearer authentication covers the reserved processing route, not the whole
Gateway. Metadata endpoints (`/v1/models`, `/v1/files`, `/v1/batches`) and direct
`model`-header/custom routes require separate protection. Keep `failOpen: false`
when relying on plugin authentication; an empty token disables it.

Built-in Redis has no persistent volume or HA. Credential changes restart affected
pods and can interrupt service or lose Redis data. Presets use
`aibrix-redis-master`; override all three client hosts if changing release identity.
Generated TLS certificates are self-signed; renewal requires Helm rendering with
cluster lookup, not a continuous renewal controller.

## Metrics and cleanup

ServiceMonitors target HTTP port `http`. Prometheus Operator must be installed and
configured to select their labels and namespace. Tracing requires a collector;
Go plugin export needs separate OTEL endpoint environment settings.

Delete ModelAdapters before uninstalling their controller. Remove stuck finalizers
only after checking cleanup responsibilities. Allow at least five minutes for
webhook certificate startup when upgrading or rolling back.

See the [upstream FAQ](https://aibrix.readthedocs.io/latest/getting_started/faq.html)
and [upgrade guide](UPGRADING.md).
