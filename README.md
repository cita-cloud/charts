# charts

### Prerequisites
- Kubernetes 1.17+
- Helm 3.5.4

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the `helm` binary is in the `PATH` of your shell.

### Using Helm

Once you have installed the Helm client, you can deploy a Helm Chart into a Kubernetes cluster.

Please refer to the [Quick Start guide](https://helm.sh/docs/intro/quickstart/) if you wish to get running in just a few commands, otherwise the [Using Helm Guide](https://helm.sh/docs/intro/using_helm/) provides detailed instructions on how to use the Helm client to manage packages on your Kubernetes cluster.

Useful Helm Client Commands:
* Install a chart: `helm install test-chain cita-cloud-local-cluster`
* List your application: `helm list`
* Uninstall a chart: `helm unintall test-chain`

### docs of chart

generated by `helm-docs`:

```
docker run --rm -v "$(pwd):/helm-docs" jnorwood/helm-docs:latest
```

### introduce charts

cita-cloud-pvc - Create PVC for CITA-Cloud

```
helm install local-pvc ./cita-cloud-pvc
```

cita-cloud-local-cluster - Setup CITA-Cloud blockchain in one k8s cluster.

```
helm install test-chain ./cita-cloud-local-cluster
```