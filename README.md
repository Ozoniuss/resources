# Resources

Holds my Kubernetes manifests.

## Repository structure

Each top-level folder is reconciled by its own Flux Kustomization, defined in `flux/kustomize.yaml`:

- `flux/` — Flux itself. `flux-system/` holds the generated bootstrap manifests, and `kustomize.yaml` defines the Flux Kustomizations that reconcile all the other folders. Applied by the `flux-system` Kustomization (path `./flux`).
- `kinfra/` — cluster infrastructure: namespaces and Helm repositories. Applied by the `infra` Kustomization.
- `koperator/` — operators installed as HelmReleases (sealed-secrets, external-secrets). Applied by the `operator` Kustomization.
- `kinfra-auth/` — authentication against Infisical: the sealed machine identity credentials and the ClusterSecretStore. Applied by the `infra-auth` Kustomization.
- `kapps/` — applications. Applied by the `apps` Kustomization.

Conventions for `kapps/`:

- Every app living in its own namespace gets a folder named exactly like its namespace (e.g. `cloudflare/`, `lifebuddies/`).
- Plain manifests that don't warrant their own namespace (no helm chart, simple test deployments etc.) go in `default2/` and are deployed to the `default2` namespace.
- Each folder has a `kustomization.yaml` listing its manifests and is referenced from `kapps/kustomization.yaml`.

Namespaces are created in `kinfra/namespaces.yaml`, not in the app folders.

## Reconciliation order

1. `flux-system` (path `./flux`) — bootstraps Flux and applies the Kustomizations below.
2. `infra`, `operator` and `infra-auth` — no dependencies between them, they reconcile independently.
3. `apps` — has `dependsOn: infra`, so it only reconciles after `infra` is ready (namespaces must exist before apps are deployed into them).

All Kustomizations have `prune: true` (deleting a manifest from git deletes the resource from the cluster) and `wait: true`.

## Cluster notes

### rp8 is tainted 

I reserve rp8 (the k3s control-plane node) to run other stuff on it (e.g. music.ozoniuss.com) so I want to avoid scheduling pods there to save resources:

```
kubectl taint nodes rp8 node-role.kubernetes.io/control-plane=:NoSchedule
```

This one should be already tolerated by system components (coredns, traefik, metrics-server, local-path-provisioner,
svclb-traefik) already tolerate it. Workloads that should still run on rp8 (e.g. the cloudflared DaemonSet) carry an explicit toleration in their manifests.

## Useful commands

Example [reference](https://fluxcd.io/flux/faq/#how-can-i-safely-move-resources-from-one-dir-to-another)

Force reconcile (you might want to disable pruning first if moving from one ks to another):

```
flux reconcile ks <kustomization> --with-source
flux reconcile ks flux-system --with-source
```

View kustomization:

```
flux export ks <kustomization>
flux export ks flux-system
```

See what is managed by Kustomization:
```
flux tree ks <kustomization>
flux tree ks flux-system
```

See how your local changes will apply to the cluster by some Kustomization:
```
flux diff ks <kustomization> --path=<ks-path>
flux diff ks apps --path=./kapps
```

