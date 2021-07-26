# cita-cloud-multi-cluster-node

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 6.0.0](https://img.shields.io/badge/AppVersion-6.0.0-informational?style=flat-square)

Setup CITA-Cloud node in multi k8s cluster

**Homepage:** <https://github.com/cita-cloud/charts/tree/master/cita-cloud-multi-cluster-node>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Rivtower Technologies | contact@rivtower.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.chainName | string | `"test-chain"` | Chain name of cita-cloud blockchain that will be setup. |
| config.kmsPassword | string | `"123456"` | Password of kms. |
| config.nodeIndex | int | `0` | Node index of the node that will be setup. |
| consensus.imageName | string | `"citacloud/consensus_bft"` | docker image of consensus container. citacloud/consensus_raft or citacloud/consensus_bft |
| consensus.imageTag | string | `"latest"` | Image tag of consensus container. |
| controller.imageName | string | `"citacloud/controller"` | docker image of controller container. |
| controller.imageTag | string | `"latest"` | Image tag of controller container. |
| debug.enabled | bool | `true` | Is there a debug container in each pod? |
| debug.imageName | string | `"praqma/network-multitool"` | Image name of debug container. |
| debug.imageTag | string | `"latest"` | Image tag of debug container. |
| executor.imageName | string | `"citacloud/executor_evm"` | docker image of executor container. citacloud/executor_evm or citacloud/executor_poc or citacloud/executor_chaincode_ext |
| executor.imageTag | string | `"latest"` | Image tag of executor container. |
| image.pullPolicy | string | `"Always"` | pullPolicy for all docker images IfNotPresent/Always. |
| kms.imageName | string | `"citacloud/kms_sm"` | docker image of kms container. citacloud/kms_sm or citacloud/kms_eth |
| kms.imageTag | string | `"latest"` | Image tag of kms container. |
| network.imageName | string | `"citacloud/network_p2p"` | docker image of network container. citacloud/network_p2p or citacloud/network_direct |
| network.imageTag | string | `"latest"` | Image tag of network container. |
| pvcName | string | `"local-pvc"` | Name of persistentVolumeClaim. |
| stateDB.imageName | string | `"couchdb"` | docker image of stateDB container. |
| stateDB.imageTag | string | `"latest"` | Image tag of stateDB container. |
| storage.imageName | string | `"citacloud/storage_rocksdb"` | docker image of storage container. citacloud/storage_rocksdb or citacloud/storage_sqlite |
| storage.imageTag | string | `"latest"` | Image tag of storage container. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.4.0](https://github.com/norwoodj/helm-docs/releases/v1.4.0)