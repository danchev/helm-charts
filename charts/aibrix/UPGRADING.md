# AIBrix upgrades

Stay close to upstream and keep validated fixes. Reassess local differences with
upstream updates; document necessary migrations rather than preserving bugs.

## 0.7.0 → 0.8.0

Apply the [matching dependencies](README.md#dependencies), then review and update
CRDs before upgrading. Helm retains CRDs on uninstall and does not upgrade or
roll them back. Use `--skip-crds` when they are managed externally.

The commands below require a published chart. Use `--force-conflicts` only after
confirming this chart owns the CRDs and reviewing the changed schema fields.

```bash
helm show crds danchev/aibrix --version 0.8.0 | kubectl apply --server-side --force-conflicts -f -
helm upgrade aibrix danchev/aibrix --version 0.8.0 -n aibrix-system -f my-values.yaml --wait --timeout 5m
```

Use a reviewed values file. To preserve stored overrides, use
`--reset-then-reuse-values`; `--reuse-values` omits new defaults and can fail.

- `metadata.redis.password` now enables server authentication as well as client
  authentication. Restarting built-in Redis can lose data.
- Replace `AIBRIX_PREFIX_CACHE_POD_RUNNING_REQUEST_IMBALANCE_ABS_COUNT` with
  `AIBRIX_LOAD_BALANCE_IMBALANCE_MIN_GAP` in custom gateway environment overrides.
- Configure managed-gateway tracing with a collector; sampling is an integer
  from 0 to 100. These settings do not configure sidecar tracing.
- Review experimental ModelWarmup objects: admission now enforces the controller's
  validator. ModelClaim is also experimental.
- `crd.enable`, `crd.keep`, and `certmanager.enable` have no effect.
