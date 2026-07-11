# Resources

Holds my Kubernetes manifests.

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

