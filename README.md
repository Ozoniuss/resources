# Resources

Holds my Kubernetes manifests.

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

