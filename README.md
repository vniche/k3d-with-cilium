# kind-cilium-cluster

Create k3d custom image with BPF volume mount mounted:

Create cluster:

```shell
k3d cluster create --config k3d-config.yaml
```

## Install

### Custom CLI

Since k3d has a particular need for a custom BPF volume mount command, i'm running on a customized CLI with [this changes](https://github.com/cilium/cilium-cli/pull/440).

### Stock cluster

For this cluster, i'm following the [strict kube-proxy replacement doc](https://docs.cilium.io/en/v1.10/gettingstarted/kubeproxy-free/#kubeproxy-free).

Install Cilium to cluster with strict replacement for kube-proxy:

```shell
cilium install --version 1.10.3 \
    --config kube-proxy-replacement=strict \
    --config enable-bandwidth-manager=true
```

### Tuning

Install tuned Cilium following this [doc](https://docs.cilium.io/en/stable/operations/performance/tuning/).

```shell
cilium install --version 1.10.3 \
    --config kube-proxy-replacement=strict \
    --config tunnel=disabled \
    --config install-no-conntrack-iptables-rules=true \
    --config enable-bandwidth-manager=true \
    --config native-routing-cidr="10.244.0.0/16" \
    --config auto-direct-node-routes=true \
    --config node-port-mode=hybrid \
    --config node-port-acceleration=native
```

## Troubleshooting

To troubleshoot, there is an [extensive doc](https://docs.cilium.io/en/stable/operations/troubleshooting/) on how to do so.

```shell
kubectl create ns cilium-test
kubectl apply --namespace=cilium-test -f connectivity-check.yaml
```